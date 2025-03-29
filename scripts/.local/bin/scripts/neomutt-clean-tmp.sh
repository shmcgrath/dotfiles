#!/usr/bin/env bash

TARGET="$HOME/.cache/neomutt/tmp"

if [ -d "$TARGET" ]; then
    find "$TARGET" -type f -mtime +7 -delete
fi
