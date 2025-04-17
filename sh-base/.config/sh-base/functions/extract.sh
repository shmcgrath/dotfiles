# unzips most common file types
extract() {
    if [ "$#" -eq 0 ]; then
        printf 'Usage: extract <file1> [file2 ...]\n'
        return 1
    fi

    for file in "$@"; do
        if [ ! -f "$file" ]; then
            printf "'%s' is not a valid file\n" "$file"
            continue
        fi

        case "$file" in
            *.tar.bz2 | *.tbz2)
                command -v tar >/dev/null 2>&1 && tar -xjf "$file" || printf "tar not found, install it first\n"
                ;;
            *.tar.gz | *.tgz)
                command -v tar >/dev/null 2>&1 && tar -xzf "$file" || printf "tar not found, install it first\n"
                ;;
            *.tar.xz | *.txz)
                command -v tar >/dev/null 2>&1 && tar -xJf "$file" || printf "tar not found, install it first\n"
                ;;
            *.tar)
                command -v tar >/dev/null 2>&1 && tar -xf "$file" || printf "tar not found, install it first\n"
                ;;
            *.gz)
                command -v gunzip >/dev/null 2>&1 && gunzip "$file" || printf "gunzip not found, install it first\n"
                ;;
            *.bz2)
                command -v bunzip2 >/dev/null 2>&1 && bunzip2 "$file" || printf "bunzip2 not found, install it first\n"
                ;;
            *.xz)
                command -v xz >/dev/null 2>&1 && xz -d "$file" || printf "xz not found, install it first\n"
                ;;
            *.zip)
                command -v unzip >/dev/null 2>&1 && unzip "$file" || printf "unzip not found, install it first\n"
                ;;
            *.rar)
                command -v unrar >/dev/null 2>&1 && unrar x "$file" || printf "unrar not found, install it first\n"
                ;;
            *.7z)
                command -v 7z >/dev/null 2>&1 && 7z x "$file" || printf "7z not found, install it first\n"
                ;;
            *.Z)
                command -v uncompress >/dev/null 2>&1 && uncompress "$file" || printf "uncompress not found, install it first\n"
                ;;
            *)
                printf "'%s' cannot be extracted: unknown format\n" "$file"
                ;;
        esac
    done
}
