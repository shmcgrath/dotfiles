#!/bin/bash

dateTimeRaw=$(date +%Y%m%d%H%M)
echo "URL of the video to download:"
read downloadURL
youtube-dl -F "$downloadURL"
echo "Format code of video to download:"
read formatCode
echo "Authorization header (if using Chrome from browser~ssai) (include \"authorization:)\":"
read authorizationHeader
echo "Save file name (do not include .mp4 or any extension):"
read saveName
fileName="$saveName-$dateTimeRaw"
youtube-dl -f $formatCode "$downloadURL" --add-header="$authorizationHeader" -o ~/Videos/youtube-dl/$fileName.mp4
