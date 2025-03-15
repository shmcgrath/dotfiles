#!/usr/bin/env bash

# Check if Dropbox is running
if ! pgrep -x dropbox > /dev/null; then
    echo "Dropbox is not running. Starting it now..."
    dropbox start -i &
else
    echo "Dropbox is already running."
fi
