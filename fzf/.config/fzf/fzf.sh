export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/fzfrc"

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:wrap --border-label=History"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# search local arch wiki
# there is a script in bootstrap to build it
# idea taken from https://github.com/filiparag/wikiman
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

# vim:ft=sh:
