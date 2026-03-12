#!/bin/bash

# === Configuration ===
WTF_FOLDER="$HOME/Games/battlenet/drive_c/Program Files (x86)/World of Warcraft/_retail_/WTF"
DEST_FOLDER="$HOME/wow-wtf"
DATE=$(date +%Y-%m-%d)
BACKUP_NAME="${DATE}-wow-wtf.zip"

# Ensure destination exists
mkdir -p "$DEST_FOLDER"

# Create the zip backup
zip -r "$DEST_FOLDER/$BACKUP_NAME" "$WTF_FOLDER"

echo "Backup created: $DEST_FOLDER/$BACKUP_NAME"

# === Cleanup old backups ===
# Keep only the 3 most recent, trash the rest
cd "$DEST_FOLDER" || exit

# List zip files sorted by creation time, oldest first
BACKUPS=( $(ls -1tr *.zip 2>/dev/null) )

NUM_BACKUPS=${#BACKUPS[@]}

if [ "$NUM_BACKUPS" -gt 3 ]; then
    NUM_TO_DELETE=$((NUM_BACKUPS - 3))
    for ((i=0; i<NUM_TO_DELETE; i++)); do
        echo "Trashing old backup: ${BACKUPS[i]}"
        trash-put "${BACKUPS[i]}"
    done
fi

echo "Backup rotation complete."
