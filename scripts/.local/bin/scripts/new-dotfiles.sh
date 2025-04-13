#!/usr/bin/env bash
set --errexit --nounset --pipefail

DOTFILES_DIR="$HOME/dotfiles"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <name>"
    exit 1
fi

TARGET_NAME="$1"
BASE_DIR="${DOTFILES_DIR}/${TARGET_NAME}"

makedir() {
    mkdir --parents --verbose "$1"
}

declare -A DIR_MAP=(
    [1]="${BASE_DIR}/.config/${TARGET_NAME}"
    [2]="${BASE_DIR}/.cache/${TARGET_NAME}"
    [3]="${BASE_DIR}/.local/share/${TARGET_NAME}"
    [4]="${BASE_DIR}/.local/state/${TARGET_NAME}"
    [5]="${BASE_DIR}/.local/bin/${TARGET_NAME}"
    [6]="${BASE_DIR}/.config/systemd/user/"
)


echo "Which directories do you want to create under $BASE_DIR?"
echo "Enter one or more numbers (space or comma separated), or 'all' to create everything:"
echo "  1:  .config (XDG_CONFIG_HOME)"
echo "  2:  .cache (XDG_CACHE_HOME)"
echo "  3:  .local/share (XDG_DATA_HOME)"
echo "  4:  .local/state (XDG_STATE_HOME)"
echo "  5:  .local/bin"
echo "  6:  .config/systemd/user"
echo "all:  make all subdirectories"
echo "exit: make no directories and exit"

read -r -p "Selection: " SELECTION



if [[ "$SELECTION" == "exit" ]]; then
    echo "Exiting. No subdirectories created."
    exit 0
elif [[ "$SELECTION" == "all" ]]; then
	makedir "$BASE_DIR"
    CHOICES=(1 2 3 4 5 6)
else
	makedir "$BASE_DIR"
    IFS=', ' read -r -a CHOICES <<< "$SELECTION"
fi

for choice in "${CHOICES[@]}"; do
	makedir "${DIR_MAP[$choice]}"
done
