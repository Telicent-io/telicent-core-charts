#!/bin/bash

# Script to update README and schema files for all charts
# Note: We don't use 'set -e' here to handle readme-generator-for-helm errors gracefully

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default to using local binary
USE_CI=false
README_GENERATOR_CMD=".dev/readme-generator-for-helm"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --ci)
      USE_CI=true
      README_GENERATOR_CMD="readme-generator-for-helm"
      shift
      ;;
    -h|--help)
      echo "Usage: $0 [--ci] [--help]"
      echo "  --ci     Use npm-installed readme-generator-for-helm instead of local binary"
      echo "  --help   Show this help message"
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

if [[ "$USE_CI" == true ]]; then
  echo -e "${GREEN}Starting metadata update for all charts (using npm-installed readme-generator-for-helm)...${NC}"
else
  echo -e "${GREEN}Starting metadata update for all charts...${NC}"
fi

# Define ignore list for charts that should be skipped
IGNORE_LIST=(
  "demo-prereqs-gateways"
  "demo-prereqs-kafka"
  "demo-prereqs-keycloak"
  "demo-prereqs-mongodb"
  "gateway-apps"
  "gateway-authn"
)

# Function to check if chart should be ignored
should_ignore_chart() {
  local chart_name=$1
  for ignored in "${IGNORE_LIST[@]}"; do
    if [[ "$chart_name" == "$ignored" ]]; then
      return 0  # true, should ignore
    fi
  done
  return 1  # false, should not ignore
}

# Check if the main config exists
if [[ ! -f "charts/telicent-core/readme.config" ]]; then
  echo -e "${RED}Error: charts/telicent-core/readme.config not found${NC}"
  exit 1
fi

# Check if readme-generator-for-helm tool exists
if [[ "$USE_CI" == true ]]; then
  if ! command -v readme-generator-for-helm &> /dev/null; then
    echo -e "${RED}Error: readme-generator-for-helm not found in PATH${NC}"
    echo -e "${YELLOW}Please ensure readme-generator-for-helm is installed via npm (e.g., npm install -g readme-generator-for-helm)${NC}"
    exit 1
  fi
else
  if [[ ! -f ".dev/readme-generator-for-helm" ]]; then
    echo -e "${RED}Error: .dev/readme-generator-for-helm not found${NC}"
    echo -e "${YELLOW}Please ensure the readme-generator-for-helm tool is installed and executable${NC}"
    exit 1
  fi
fi

# Create temporary files to track results across subshell
tmp_successful=$(mktemp)
tmp_failed=$(mktemp)
tmp_skipped=$(mktemp)
tmp_missing_keys=$(mktemp)

# Cleanup function
cleanup() {
  rm -f "$tmp_successful" "$tmp_failed" "$tmp_skipped" "$tmp_missing_keys"
}
trap cleanup EXIT

# Find all chart directories (containing Chart.yaml) only in charts/ directory, excluding hidden dirs
find charts -name "Chart.yaml" -type f -not -path "*/.*" | while read -r chart_file; do
  chart_dir=$(dirname "$chart_file")
  chart_name=$(basename "$chart_dir")
  
  # Check if chart should be ignored
  if should_ignore_chart "$chart_name"; then
    echo -e "${YELLOW}Skipping ignored chart: $chart_name${NC}"
    echo "$chart_name (ignored)" >> "$tmp_skipped"
    continue
  fi
  
  echo -e "${YELLOW}Processing chart: $chart_name${NC}"
  
  # Check if values.yaml exists
  if [[ ! -f "$chart_dir/values.yaml" ]]; then
    echo -e "${RED}Warning: $chart_dir/values.yaml not found, skipping...${NC}"
    echo "$chart_name (missing values.yaml)" >> "$tmp_skipped"
    continue
  fi
  
  # Run the readme generator using telicent-core config
  echo $chart_dir
  echo "  Updating README and schema for $chart_name..."
  
  # Capture output and exit code from readme-generator-for-helm
  output_file=$(mktemp)
  if $README_GENERATOR_CMD \
    --config="charts/telicent-core/readme.config" \
    --values="$chart_dir/values.yaml" \
    --readme="$chart_dir/README.md" \
    --schema="$chart_dir/values.schema.json" > "$output_file" 2>&1; then
    
    echo -e "${GREEN}  ✓ Completed $chart_name${NC}"
    echo "$chart_name" >> "$tmp_successful"
  else
    exit_code=$?
    echo -e "${RED}  ✗ Failed to process $chart_name (exit code: $exit_code)${NC}"
    echo "$chart_name" >> "$tmp_failed"
    
    # Read the output to check for missing metadata keys
    output_content=$(cat "$output_file")
    echo -e "${BLUE}  Output from $README_GENERATOR_CMD:${NC}"
    echo "$output_content" | sed 's/^/    /'
    
    # Check for common patterns that indicate missing metadata keys
    if echo "$output_content" | grep -qi "missing.*key\|required.*key\|@key.*missing\|metadata.*missing\|key.*not.*found"; then
      echo -e "${YELLOW}  Possible missing metadata keys detected. Please check:${NC}"
      echo -e "${YELLOW}    - Ensure all configuration values have @key annotations${NC}"
      echo -e "${YELLOW}    - Check values.yaml for proper documentation format${NC}"
      echo -e "${YELLOW}    - Verify readme.config contains all required sections${NC}"
    fi
    
    # Extract specific missing keys if the pattern matches
    missing_keys=$(echo "$output_content" | grep -iE "missing.*key|required.*key|key.*not.*found|@key.*missing" || true)
    if [[ -n "$missing_keys" ]]; then
      echo -e "${RED}  Missing keys found:${NC}"
      echo "$missing_keys" | sed 's/^/    /'
      
      # Store missing keys with chart name for summary
      while IFS= read -r key_line; do
        if [[ -n "$key_line" ]]; then
          # Extract just the key name from the error message
          key_name=$(echo "$key_line" | grep -oE "key: [^[:space:]]*" | sed 's/key: //' || echo "$key_line")
          echo "$chart_name: $key_name" >> "$tmp_missing_keys"
        fi
      done <<< "$missing_keys"
    fi
    
    # Also check for validation errors or schema issues
    validation_errors=$(echo "$output_content" | grep -iE "validation.*error|schema.*error|invalid.*format|parse.*error" || true)
    if [[ -n "$validation_errors" ]]; then
      echo -e "${RED}  Validation errors:${NC}"
      echo "$validation_errors" | sed 's/^/    /'
    fi
    
    echo ""
  fi
  
  # Clean up temporary file
  rm -f "$output_file"
done

# Print summary
echo ""
echo "================================="
echo -e "${BLUE}PROCESSING SUMMARY${NC}"
echo "================================="

# Read results from temporary files
successful_count=0
failed_count=0
skipped_count=0

if [[ -s "$tmp_successful" ]]; then
  successful_count=$(wc -l < "$tmp_successful")
  echo -e "${GREEN}Successfully processed charts ($successful_count):${NC}"
  while IFS= read -r chart; do
    echo -e "  ${GREEN}✓${NC} $chart"
  done < "$tmp_successful"
fi

if [[ -s "$tmp_skipped" ]]; then
  skipped_count=$(wc -l < "$tmp_skipped")
  echo ""
  echo -e "${YELLOW}Skipped charts ($skipped_count):${NC}"
  while IFS= read -r chart; do
    echo -e "  ${YELLOW}○${NC} $chart"
  done < "$tmp_skipped"
fi

if [[ -s "$tmp_failed" ]]; then
  failed_count=$(wc -l < "$tmp_failed")
  echo ""
  echo -e "${RED}Failed to process charts ($failed_count):${NC}"
  while IFS= read -r chart; do
    echo -e "  ${RED}✗${NC} $chart"
  done < "$tmp_failed"
  echo ""
  echo -e "${YELLOW}Common solutions for metadata key errors:${NC}"
  echo -e "${YELLOW}  1. Add @key annotations to all configuration values in values.yaml${NC}"
  echo -e "${YELLOW}  2. Ensure @section and @descStart/@descEnd are properly formatted${NC}"
  echo -e "${YELLOW}  3. Check that readme.config includes all required sections${NC}"
  echo -e "${YELLOW}  4. Verify values.yaml syntax is valid YAML${NC}"
  echo ""
  
  # Show detailed missing keys summary if any exist
  if [[ -s "$tmp_missing_keys" ]]; then
    echo "================================="
    echo -e "${RED}MISSING METADATA KEYS SUMMARY${NC}"
    echo "================================="
    
    # Sort and display missing keys by chart
    sort "$tmp_missing_keys" | while IFS=': ' read -r chart_name key_info; do
      echo -e "${RED}●${NC} ${BLUE}$chart_name${NC}: $key_info"
    done
    echo ""
  fi
  
  exit 1
else
  echo ""
  echo -e "${GREEN}All charts processed successfully!${NC}"
fi