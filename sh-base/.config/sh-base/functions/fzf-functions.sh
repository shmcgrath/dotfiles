farch() {
    # Make sure path exists
	[ -d "$XDG_DATA_HOME/doc/arch-wiki/html" ] || return 1

    # List all HTML files with cleaned-up titles
    local file
    file=$(find "$XDG_DATA_HOME/doc/arch-wiki/html" -type f -name '*.html' 2>/dev/null | \
        awk -F'/' '
            BEGIN { IGNORECASE=1; OFS="\t" }
            {
                # Build title from last path component
                title = $NF;
                gsub(/\.html$/, "", title);
                gsub("_", " ", title);

                # Handle Category prefix
                if (title ~ /^Category:/) {
                    gsub(/^Category:/, "", title);
                    title = title " (Category)";
                }

                print title "\t" $0
            }
        ' | fzf --delimiter=$'\t' --with-nth=1 --preview 'w3m -dump "$(echo {} | cut -f2)"' | cut -f2)

    # If a file was selected, open it in w3m
    [ -n "$file" ] && w3m "$file"
}
