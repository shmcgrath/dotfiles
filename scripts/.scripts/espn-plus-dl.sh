#!/usr/bin/env bash

dateTimeRaw=$(date +%Y%m%d%H%M%S)
echo "URL of the video to download (search for m3u8 in the bar; wil be a 302):"
read downloadURL
youtube-dl -F "$downloadURL"
echo "Format code of video to download:"
read formatCode
echo "Authorization header (browser~ssai above the 302 request URL) (include \"authorization:)\":"
read authorizationHeader
echo "Save file name (do not include .mp4 or any extension):"
read saveName
fileName=$saveName-$dateTimeRaw
youtube-dl -f $formatCode "$downloadURL" --add-header="$authorizationHeader" -o "/home/shmcg/Videos/youtube-dl/$fileName.mp4"
