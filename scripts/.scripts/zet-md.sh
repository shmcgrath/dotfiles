#!/usr/bin/env bash
# This creates a new .md Zettel in ~/Dropbox/notes

dateTimeRaw=$(date +%Y%m%d%H%M)
dateFormatted=$(date +%Y-%m-%d%n)
timeFormatted=$(date +%H:%M)
notesDirectory="$HOME/Dropbox/notes"

read -p 'Zettel Title: ' zetTitle
read -p 'Zettel Tags: ' zetTags

zetFileName="$dateTimeRaw.md"
fullFileName="$notesDirectory/$zetFileName"

zetText="---
title: $zetTitle
date: $dateFormatted $timeFormatted
tags: $zetTags
...

# $zetTitle

"

cat<<EOF>$fullFileName
$zetText
EOF

echo "Zettel created; opening in Vim."
sleep 1

vim $fullFileName
