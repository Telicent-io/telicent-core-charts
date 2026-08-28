#!/usr/bin/env bash
# Verifies that every quay.io chart dependency referenced by a Chart.yaml
# actually exists in the registry at the version it is pinned to.
#
# Every remote dependency in this repo is an OCI Helm chart hosted under
# oci://quay.io/telicent/charts, so existence is checked with `helm show chart`,
# which resolves the reference against the registry without unpacking it. Semver
# ranges (e.g. ^1.2.0) are resolved the same way helm would resolve them during
# `helm dependency update`, and the version they resolve to is reported.
#
# Private repositories need credentials - run `helm registry login quay.io`
# (or the docker/login-action step in CI) before this script.
#
# Writes a markdown report to stdout and a human readable log to stderr.
# Exits non-zero if any dependency could not be resolved.
set -uo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <chart-root> [<chart-root> ...]" >&2
  exit 1
fi

# Cache lookups so a dependency shared by several charts is only resolved once.
# A directory of files rather than an associative array, so this runs on the
# bash 3.2 shipped with macOS as well as on the runners.
CACHE_DIR=$(mktemp -d)
trap 'rm -rf "$CACHE_DIR"' EXIT

rows=()
failures=0
checked=0

resolve_dependency() {
  # Populates the globals `status` and `detail` for one <ref>:<version> pair.
  local ref="$1" version="$2"
  local cache_file
  cache_file="${CACHE_DIR}/$(printf '%s:%s' "$ref" "$version" | tr -c '[:alnum:]._-' '_')"

  if [ -f "$cache_file" ]; then
    IFS='|' read -r status detail <"$cache_file"
    return
  fi

  local stderr rc
  stderr=$(mktemp)
  helm show chart "$ref" --version "$version" >/dev/null 2>"$stderr"
  rc=$?

  if [ $rc -eq 0 ]; then
    status="ok"
    # helm reports the tag it actually resolved to on stderr as
    # "Pulled: <ref>:<tag>" - that is the resolved version, not the chart's
    # own .version metadata, which is free to differ from its tag.
    detail=$(grep '^Pulled:' "$stderr" | tail -n 1 | sed 's/.*://')
    [ -n "$detail" ] || detail="$version"
  else
    status="missing"
    # helm errors are multi-line; keep the last line, which carries the cause.
    detail=$(tail -n 1 "$stderr" | sed 's/^Error: //')
    # That line repeats the reference twice ("failed to resolve <ref>: <ref>:
    # not found") which is noise in a table already keyed by reference.
    case "$detail" in
      *"not found"*) detail="not found in registry" ;;
      *unauthorized*|*UNAUTHORIZED*) detail="unauthorized - check the registry credentials" ;;
    esac
  fi
  rm -f "$stderr"

  printf '%s|%s\n' "$status" "$detail" >"$cache_file"
}

for CHART_ROOT in "$@"; do
  if [ ! -d "$CHART_ROOT" ]; then
    echo "No such directory: ${CHART_ROOT}" >&2
    exit 1
  fi

  while IFS= read -r chart_file; do
    while IFS=$'\t' read -r name version repository; do
      [ -n "$name" ] || continue

      ref="${repository%/}/${name}"
      resolve_dependency "$ref" "$version"
      checked=$((checked + 1))

      if [ "$status" = "ok" ]; then
        echo "OK      ${ref}:${version} (${chart_file})" >&2
        if [ "$detail" = "$version" ]; then
          rows+=("| \`${chart_file}\` | \`${name}\` | \`${version}\` | :white_check_mark: found |")
        else
          rows+=("| \`${chart_file}\` | \`${name}\` | \`${version}\` | :white_check_mark: found (resolves to \`${detail}\`) |")
        fi
      else
        failures=$((failures + 1))
        echo "MISSING ${ref}:${version} (${chart_file}): ${detail}" >&2
        echo "::error file=${chart_file},title=Missing chart dependency::${ref}:${version} could not be resolved - ${detail}" >&2
        rows+=("| \`${chart_file}\` | \`${name}\` | \`${version}\` | :x: ${detail} |")
      fi
    done < <(yq -r '.dependencies[]? | select(.repository | test("quay\.io")) | [.name, .version, .repository] | @tsv' "$chart_file")
  done < <(find "$CHART_ROOT" -name Chart.yaml | sort)
done

# Markdown report on stdout
echo "## Quay.io chart dependency check"
echo
if [ "$checked" -eq 0 ]; then
  echo ":grey_question: No quay.io chart dependencies found."
elif [ "$failures" -eq 0 ]; then
  echo ":white_check_mark: All **${checked}** quay.io chart dependencies exist in the registry."
else
  echo ":x: **${failures}** of **${checked}** quay.io chart dependencies could not be resolved."
fi

if [ "$checked" -gt 0 ]; then
  echo
  echo "| Chart | Dependency | Version | Status |"
  echo "| --- | --- | --- | --- |"
  printf '%s\n' "${rows[@]}"
fi

[ "$failures" -eq 0 ]
