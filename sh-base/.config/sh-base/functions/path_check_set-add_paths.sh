validate_path() {
	# checks the number of input arguments supplied
	# if the arguments supplied equal 0, exit
	if [ $# -eq 0 ]; then
		printf "%s\n" "[E01] No arguments supplied to path_check_set."
		return 1
	fi

	# checks if the first argument is an empty string
	# if it is a null string, the printf is called
	if [ -z "$1" ]; then
		printf "%s\n" "[E02] Null string supplied to path_check_set."
		return 1
	fi

	if [ ! -d "$1" ]; then
		printf "%s\n" "[E03] Directory \"$1\" does not exist."
		return 1
	fi
}

# Prepend a directory to PATH if it's not already in it
prepend_path() {
	validate_path "$1" || return 1

	new_path=""

	# Split PATH on ':' and rebuild excluding$$1
	OLD_IFS=$IFS
	IFS=:
	for p in $PATH; do
		if [ "$p" != "$1" ] && [ -n "$p" ]; then
			if [ -z "$new_path" ]; then
				new_path="$p"
			else
				new_path="$new_path:$p"
			fi
		fi
	done
	IFS=$OLD_IFS

	# Prepend 1
	if [ -z "$new_path" ]; then
		PATH="$1"
	else
		PATH="$1:$new_path"
	fi
	export PATH

	printf "%s\n" "Prepending to PATH: $1"
}


# Append a directory to PATH if it's not already in it
append_path() {
	validate_path "$1" || return 1

	case ":$PATH:" in
		*:"$1":*)
			printf "%s\n" "[E05] Directory already in PATH. Skipping: $1"
			;;
		*)
			printf "%s\n" "Appending to PATH: $1"
			PATH="$PATH:$1"
			export PATH
			;;
	esac
}

add_paths() {
	local method="append"

	if [ "$1" = "--prepend" ]; then
		method="prepend"
		shift
	fi

	for dir in "$@"; do
		case "$method" in
			prepend)
				prepend_path "$dir" ;;
			append)
				append_path "$dir" ;;
		esac
	done

	printf "%s\n" "\$PATH: $PATH"
}
