#!/usr/bin/env sh
set -eu

if [ "$#" -ne 1 ]; then
  printf 'usage: %s <git-url>\n' "$0" >&2
  exit 1
fi

url=$1

# Strip trailing .git if present
base=$(basename "$url")
repo=${base%.git}

# Extract owner/user
# Works for:
#   https://github.com/user/repo.git
#   git@github.com:user/repo.git
user=$(printf '%s\n' "$url" \
  | sed -E 's#(.*/|:)([^/]+)/[^/]+(\.git)?#\2#')

target="${repo}-${user}"

git clone "$url" "$target"
