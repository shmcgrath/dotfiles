#!/usr/bin/env bash

set -euo pipefail

file="${1:-/dev/stdin}"

awk '
# 1. Skip priority lines that already have a created date
$0 ~ /^\([A-Za-z]\)[[:space:]]+[0-9]{4}-[0-9]{2}-[0-9]{2}/ {
    next
}

# 2. Include priority lines without a date
$0 ~ /^\([A-Za-z]\)[[:space:]]+/ {
    print
    next
}

# 3. Include plain text lines (not starting with priority or a date)
$0 ~ /^[^0-9(]/ {
    print
}
' "$file"
