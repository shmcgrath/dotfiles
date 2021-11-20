#!/usr/bin/env bash
read -r -p "Perform what action? 1) Restart qtile 2) Shutdown qtile 3) Change qtile log level: " qtileCmd

case $qtileCmd in
		1)
	echo "Restarting qtile..."
	qtile cmd-obj -o cmd --function restart
	echo "~/.local/share/qtile/qtile.log latest:"
	tail "$HOME/.local/share/qtile/qtile.log"
	exit 0
	;;
		2)
	read -r -p "Confirm qtile shutdown? [Y/n]: " confimQtileShutdown
	case $confimQtileShutdown in
			[yY][eE][sS]|[yY])
		echo "Shutdown qtile..."
		qtile cmd-obj -o cmd --function shutdown
		exit 0
		;;
			[nN][oO]|[nN])
		echo "Aborting qtile shutdown. Exiting."
		exit 0
		;;
			*)
		echo "Invalid input. Exiting."
		exit 1
		;;
	esac
	exit 0
	;;
		3)
	echo "If needed, I will add commands to change the log level. Exiting."
	exit 0
	;;
		*)
	echo "Invalid input. Exiting."
	exit 1
	;;
esac
