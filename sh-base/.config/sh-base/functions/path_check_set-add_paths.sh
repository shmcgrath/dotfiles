path_check_set () {
	# checks the number of input arguments supplied
	# if the arguments supplied equal 0, exit
	if [ $# -eq 0 ]; then
		printf "%s\n" "No arguments supplied to path_check_set. Failure 01"
		return 1
	fi

	# checks if the first argument is an empty string
	# if it is a null string, the printf is called
	if [ -z "$1" ]; then
		printf "%s\n" "Null string supplied to path_check_set. Failure 02"
		return 1
	fi

	# checks if directory exists
	if [ -d "$1" ]; then
		printf "%s\n" "Path to add for path_check_set: $1"
		case ":$PATH:" in
			*:"$1":*)
				printf "%s\n" "Path already in PATH. Failure 03"
				return 0
				;;
			*)
				printf "%s\n" "Adding path to PATH."
				PATH="$1":$PATH
				export PATH
				return 0
				;;
		esac
	fi
	printf "%s\n" "path_check_set did not add to PATH because $1 did not meet any criteria. Failure 04"
	return 1
}

add_paths() {
	for dir in "$@"; do
		path_check_set "$dir"
	done
	printf "%s\n" "\$PATH: $PATH"
}
