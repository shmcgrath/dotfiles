#!/usr/bin/env bash

# Check for input argument
if [ -z "$1" ]; then
    echo "Usage: $0 <ls_colors_file>"
    exit 1
fi

INPUT_FILE="$1"

# Define color palette variables
declare -A COLORS=(
    ["22;24;26"]="cd_bg"
    ["30;33;36"]="cd_bg_alt"
    ["60;64;72"]="cd_bg_highlight"
    ["255;255;255"]="cd_fg"
    ["123;132;150"]="cd_gray"
    ["94;161;255"]="cd_blue"
    ["94;255;108"]="cd_green"
    ["94;241;255"]="cd_cyan"
    ["255;110;94"]="cd_red"
    ["241;255;94"]="cd_yellow"
    ["255;94;241"]="cd_magenta"
	["255;94;160"]="cd_pink"
    ["255;189;94"]="cd_orange"
    ["189;94;255"]="cd_purple"
)

# Convert numeric flags to gui
flag_to_gui() {
    case "$1" in
        1) echo "bold" ;;
        3) echo "italic" ;;
        4) echo "underline" ;;
        7) echo "reverse" ;;
        9) echo "strikethrough" ;;
        *) echo "NONE" ;;
    esac
}

# Map RGB to nearest variable
rgb_to_var() {
    rgb="$1;$2;$3"
    var="${COLORS[$rgb]}"
    if [ -z "$var" ]; then
        echo "UNKNOWN"
    else
        echo "$var"
    fi
}

while read -r line; do
    [ -z "$line" ] && continue
    name=$(awk '{print $1}' <<<"$line")
    codes=$(awk '{$1=""; print $0}' <<<"$line" | xargs)

    gui="NONE"
    fg="fg"
    bg="NONE"

    IFS=';' read -ra arr <<< "$codes"
    i=0
    while [ $i -lt ${#arr[@]} ]; do
        val="${arr[$i]}"
        case "$val" in
            0|1|3|4|7|9)
                gui=$(flag_to_gui "$val")
                ((i++))
                ;;
            38)
                # foreground
                if [ "${arr[$((i+1))]}" == "2" ]; then
                    r=${arr[$((i+2))]}
                    g=${arr[$((i+3))]}
                    b=${arr[$((i+4))]}
                    fg=$(rgb_to_var "$r" "$g" "$b")
                    ((i+=5))
                else
                    ((i+=2))
                fi
                ;;
            48)
                # background
                if [ "${arr[$((i+1))]}" == "2" ]; then
                    r=${arr[$((i+2))]}
                    g=${arr[$((i+3))]}
                    b=${arr[$((i+4))]}
                    bg=$(rgb_to_var "$r" "$g" "$b")
                    ((i+=5))
                else
                    ((i+=2))
                fi
                ;;
            *)
                ((i++))
                ;;
        esac
    done

	#printf "%s gui=%s guifg=%s guibg=%s\n" "$name" "$gui" "$fg" "$bg"
	printf "%s|%s|%s|%s\n" "$name" "$gui" "$fg" "$bg"

done < "$INPUT_FILE"
