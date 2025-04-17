zipf() {
    if [ $# -ne 1 ]; then
        printf "Usage: zipf <directory>\n"
        return 1
    fi

    dir=$1

    if [ ! -d "$dir" ]; then
        printf "Error: '%s' is not a directory\n" "$dir"
        return 1
    fi

    outfile="${dir%/}.zip"  # Remove trailing slash if present

    if [ -f "$outfile" ]; then
        printf "Warning: '%s' already exists. Overwrite? [y/N]: " "$outfile"
        IFS= read -r answer
        case $answer in
            [Yy]*) ;;
            *) printf "Aborted.\n"; return 1 ;;
        esac
    fi

    zip -r "$outfile" "$dir"
}
