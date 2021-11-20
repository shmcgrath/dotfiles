#!/usr/bin/env bash
# This creates a new Journal in ~/Dropbox/notes/00-journal

dateTimeRaw=$(date +%Y%m%d%H%M)
dateDay=$(date +%d)
dateMonth=$(date +%B)
dateMonthNo=$(date +%m)
dateYear=$(date +%Y)
dateFormatted=$(date +%Y-%m-%d%n)
timeFormatted=$(date +%H:%M)
currentWeather=$(curl wttr.in/Pittsburgh?0?q?T)
journalDirectory="$HOME/Dropbox/notes/00-journal"

journalTitle="Journal - $dateDay $dateMonth $dateYear"
journalTags="#journal:$dateYear:$dateMonthNo"

journalFileName="$dateTimeRaw-journal.md"
fullFileName="$journalDirectory/$journalFileName"

journalText="---
title: $journalTitle
date: $dateFormatted $timeFormatted
tags: $journalTags
...

# $journalTitle



---
$currentWeather"

cat<<EOF>$fullFileName
$journalText
EOF

echo "Journal created; opening in Vim."
sleep 1

$EDITOR $fullFileName
