#!/bin/bash

# Script to update README and schema files for all charts
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting metadata update for all charts...${NC}"

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

# Find all chart directories (containing Chart.yaml) only in charts/ directory, excluding hidden dirs
find charts -name "Chart.yaml" -type f -not -path "*/.*" | while read -r chart_file; do
  chart_dir=$(dirname "$chart_file")
  chart_name=$(basename "$chart_dir")
  
  # Check if chart should be ignored
  if should_ignore_chart "$chart_name"; then
    echo -e "${YELLOW}Skipping ignored chart: $chart_name${NC}"
    continue
  fi
  
  echo -e "${YELLOW}Processing chart: $chart_name${NC}"
  
  # Check if values.yaml exists
  if [[ ! -f "$chart_dir/values.yaml" ]]; then
    echo -e "${RED}Warning: $chart_dir/values.yaml not found, skipping...${NC}"
    continue
  fi
  
  # Run the readme generator using telicent-core config
  echo $chart_dir
  echo "  Updating README and schema for $chart_name..."
  .dev/readme-generator-for-helm \
    --config="charts/telicent-core/readme.config" \
    --values="$chart_dir/values.yaml" \
    --readme="$chart_dir/README.md" \
    --schema="$chart_dir/values.schema.json"
  
  echo -e "${GREEN}  ✓ Completed $chart_name${NC}"
done

echo -e "${GREEN}All charts processed successfully!${NC}"