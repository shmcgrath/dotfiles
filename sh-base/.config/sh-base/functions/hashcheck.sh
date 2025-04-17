hashcheck() {
    if [ "$#" -lt 1 ]; then
        printf "Usage: hashcheck <file> [expected_checksum]\n"
        return 1
    fi

    file=$1
    if [ ! -f "$file" ]; then
        printf "Error: '%s' is not a valid file\n" "$file"
        return 1
    fi

    # Compute checksums
    cksum_actual=$(cksum "$file" | awk '{print $1}')

    if command -v md5sum >/dev/null 2>&1; then
        md5_actual=$(md5sum "$file" | awk '{print $1}')
    elif command -v md5 >/dev/null 2>&1; then
        md5_actual=$(md5 "$file" | awk '{print $NF}')
    else
        md5_actual="(md5 not available)"
    fi

    if command -v sha256sum >/dev/null 2>&1; then
        sha256_actual=$(sha256sum "$file" | awk '{print $1}')
    elif command -v shasum >/dev/null 2>&1; then
        sha256_actual=$(shasum -a 256 "$file" | awk '{print $1}')
    else
        sha256_actual="(sha256 not available)"
    fi

    # Determine expected checksum
    if [ -n "$2" ]; then
        expected=$2
    elif command -v pbpaste >/dev/null 2>&1; then
        expected=$(pbpaste)
    elif command -v xclip >/dev/null 2>&1; then
        expected=$(xclip -selection clipboard -o 2>/dev/null)
    elif command -v wl-paste >/dev/null 2>&1; then
        expected=$(wl-paste 2>/dev/null)
    else
        printf "Expected checksum not provided and clipboard unavailable.\n"
        printf "Enter expected checksum: "
        IFS= read -r expected
    fi

    # Print all computed hashes
    printf "Checksums for %s:\n" "$file"
    printf "  cksum   : %s\n" "$cksum_actual"
    printf "  md5     : %s\n" "$md5_actual"
    printf "  sha256  : %s\n" "$sha256_actual"

    # Compare
    if [ -n "$expected" ]; then
        match="no"
        for h in "$cksum_actual" "$md5_actual" "$sha256_actual"; do
            if [ "$expected" = "$h" ]; then
                match="yes"
                break
            fi
        done

        if [ "$match" = "yes" ]; then
            printf "OK: Match found for '%s'\n" "$expected"
            return 0
        else
            printf "FAIL: No match found for '%s'\n" "$expected"
            return 2
        fi
    fi
}
