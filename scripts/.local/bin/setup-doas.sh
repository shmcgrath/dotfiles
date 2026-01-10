#!/usr/bin/env bash
echo "doas configuration helper"
echo "more information on the Arch wiki: https://wiki.archlinux.org/title/Doas"
echo "This should be run as root. su root"

if [ -f /etc/doas.conf ]; then
	echo "Current /etc/doas.conf:"
	cat /etc/doas.conf
else
	read -r -p "Create /etc/doas.conf? [Y/n]: " createConf
	case $createConf in
			[yY][eE][sS]|[yY])
		echo "Creating /etc/doas.conf..."
		doasString="permit"
		read -r -N 1 -p "Enable persist feature? Type 1 for yes and 0 for no: " persistBool
		case $persistBool in
				1)
			echo -e "\nEnabling persist option"
			doasString+=" persist"
			;;
				*)
			echo -e "\nNot enabling persist option"
			;;
		esac
		read -r -N 1 -p "Enable keepenv feature? Type 1 for yes and 0 for no: " persistBool
		case $persistBool in
				1)
			echo -e "\nEnabling persist option"
			doasString+=" keepenv"
			;;
				*)
			echo -e "\nNot enabling keepenv option"
			;;
		esac
		read -r -p "Group name that allows doas access? Type 'wheel' to match sudo: " groupName
		doasString+=" :$groupName"
		echo $doasString > /tmp/doas.conf
		echo "Contents of temporary doas.conf:"
		cat /tmp/doas.conf
		echo "Checking contants of temp file for errors..."
		doas -C /tmp/doas.conf && echo "config ok" || echo "config error"
		read -r -p "Write /etc/doas.conf and set file permissions? [Y/n]: " writeDoas
		case $writeDoas in
				[yY][eE][sS]|[yY])
			cp --force /tmp/doas.conf /etc/doas.conf
			rm --force /tmp/doas.conf
			chown -c root:root /etc/doas.conf
			chmod -c 0400 /etc/doas.conf
			echo "/etc/doas.conf set up"
			exit 1
			;;
				[nN][oO]|[nN])
			rm --force /tmp/doas.conf
			echo "Exiting doas setup"
			exit 0
			;;
		esac
		;;
			[nN][oO]|[nN])
		echo "Exiting doas setup..."
		exit 0
		;;
			*)
		echo "Invalid input."
		exit 1
		;;
	esac
fi
