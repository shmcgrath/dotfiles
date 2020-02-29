#!/usr/bin/env bash

dateTimeRaw=$(date +%Y%m%d%H%M%S)
echo "search for m3u8 in the bar; will be a 302"
echo "May use Firefox extension The Stream Detector; use master_desktop_complete stream for ESPN+"
echo "URL of the video to download: "
read downloadURL
echo "Auth Header is browser~ssai above the 302 request URL OR"
echo "200 GET XHR octect stream; usually under 204 options"
echo "Authorization header (include \"authorization:\"): "
read authorizationHeader
echo "Save file name (do not include .mp4 or any extension): "
read saveName
fileName=$saveName-$dateTimeRaw
youtube-dl "$downloadURL" --add-header="$authorizationHeader" -o "/home/shmcg/video/youtube-dl/$fileName.mp4"
