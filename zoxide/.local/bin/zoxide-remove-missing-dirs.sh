zoxide query --list | while IFS= read -r dir; do
  if [ ! -d "$dir" ]; then
    printf 'Missing: %s\n' "$dir"
    printf 'Remove from zoxide? [y/N]: '
    read -r reply

    case "$reply" in
      y|Y|yes|YES)
        zoxide remove "$dir"
        printf 'Removed\n'
        ;;
      *)
        printf 'Skipped\n'
        ;;
    esac
  fi
done
