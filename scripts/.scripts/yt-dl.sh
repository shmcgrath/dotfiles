#!/usr/bin/env bash

dateTimeRaw=$(date +%Y%m%d%H%M%S)
echo "URL of the video to download: "
read downloadURL
youtube-dl -F "$downloadURL"
echo "Format code of video to download:"
read formatCode
echo "Save file name (do not include .mp4 or any extension): "
read saveName
fileName=$saveName-$dateTimeRaw
youtube-dl -f $formatCode "$downloadURL" -o "/home/shmcg/video/youtube-dl/$fileName.mp4"
