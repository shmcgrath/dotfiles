#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

dir="${HOME}/.local/share/doc"

mkdir --parents "${dir}"

curl \
    --location \
    --fail \
    --silent \
    --show-error \
    --output "${dir}/emoji-test.txt" \
    'https://unicode.org/Public/emoji/latest/emoji-test.txt'

perl "${HOME}/.local/bin/emoji-parse.pl" \
    "${dir}/emoji-test.txt" \
    > "${dir}/emoji.txt"

#rm --force "${dir}/emoji-test.txt"
