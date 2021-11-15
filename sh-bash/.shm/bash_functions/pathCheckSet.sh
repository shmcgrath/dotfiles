#!/usr/bin/env bash

pathCheckSet () {
	# checks the number of input arguments supplied
	# if the arguments supplied equal 0, exit
	if [[ $# -eq 0 ]]; then
		echo "No arguments supplied to pathCheckSet. Failure 01"
		# checks if the first argument is an empty string
		# if it is a null string, the echo is called
	elif [[ -z "$1" ]]; then
		echo "Null string supplied to pathCheckSet. Failure 02"
	# checks if directory exists
	elif [[ -d "$1" ]]; then
		echo "Path to add for pathCheckSet: $1"
		case ":$PATH:" in
			*:"$1":*)
				echo "Path to be added by pathCheckSet is already in the path. Failure 03"
				;;
			*)
				echo "Path to be added by pathCheckSet is not in the path. Adding to PATH."
				PATH=$PATH:"$1"
				export PATH
				;;
		esac
	else
		echo "pathCheckSet did not add to PATH because $1 did not meet any criteria. Failure 04"
	fi
}
