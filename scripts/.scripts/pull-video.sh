#!/usr/bin/env bash

# The Stream Detector URL: https://github.com/rowrawer/stream-detector/
echo "To find the stream via Developer Tools within a web browser, search for m3u8 in the Network filter bar. For ESPN+, it will be a 302 status."
echo "Filenames (most recent on top) to select when using The Stream Detector Firefox extension:"
echo "ESPN+: 'master_desktop_complete'"
echo "F1: 'clip_2_master' Note: there will be a more recent clip_2_master when changing to a driver onboard"
echo "Fulham FC: 'UICONFID'"
read -r -p "URL of the video to download: " downloadURL
read -r -p "Save file name (do not include .mp4 or any extension): " fileName
fileName=$(echo "$fileName" | sed 's/ /_/g')
fileName+="-$(date +%Y%m%d%H%M%S)"
echo "File name: $fileName"
echo "If the video needs remuxed (audio and video combined after download) the format code must be 'videoformat+audioformat' (i.e. '5742+Encoding_0-English') For F1 races, the output must be remuxed."
read -r -p "Are you downloading a Formula 1 race? [Y/n]: " isFormulaOne
youtube-dl -F "$downloadURL"
case $isFormulaOne in
		[yY][eE][sS]|[yY])
	read -r -p "Type in the format code for video ONLY: " formatCode
	read -r -p "Should team radio (downloading driver onboard) be used instead of the broadcast audio? [Y/n]: " isTeamRadio
	case $isTeamRadio in
			[yY][eE][sS]|[yY])
		echo "Team radio audio selected."
		formatCode+="+Encoding_0-TeamRadio"
		;;
			[nN][oO]|[nN])
		echo "Broadcast audio selected."
		formatCode+="+Encoding_0-English"
		;;
			*)
		echo "Invalid input."
		exit 1
		;;
	esac
	;;
		[nN][oO]|[nN])
	read -r -p "Format code of video: " formatCode
	;;
		*)
	echo "Invalid input."
	exit 1
	;;
esac
echo "Video format code: $formatCode"
read -r -p "Is an an additional authorization code needed for this download (i.e. ESPN+)? [Y/n]: " needAuth
case $needAuth in
		[yY][eE][sS]|[yY])
	echo "Auth Header is browser~ssai above the 302 request URL OR"
	echo "200 GET XHR octect stream; usually under 204 options"
	read -r -p "Authorization header (include 'authorization:'): " authorizationHeader
	youtube-dl -f $formatCode "$downloadURL" --add-header="$authorizationHeader" -o "~/video/youtube-dl/$fileName.%(ext)s"
	;;
		[nN][oO]|[nN])
	echo "No authorization header needed. Downloading video..."
	youtube-dl -f $formatCode "$downloadURL" -o "~/video/youtube-dl/$fileName.%(ext)s"
	;;
		*)
	echo "Invalid input."
	exit 1
	;;
esac
