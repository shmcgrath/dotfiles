zoxide query --list \
  | fzf \
      --multi \
      --prompt="Remove from zoxide> " \
      --preview='printf "%s\n" {}' \
  | xargs -r zoxide remove
