#!/usr/bin/env bash

set -euo pipefail

case "$1" in
clean)
    exec gpg --armor --default-recipient-self --batch --yes --encrypt
    ;;
smudge)
    exec gpg --batch --yes --decrypt
    ;;
*)
	printf 'Usage: %s {clean|smudge}\n' "${0##*/}" >&2
	exit 1
	;;
esac

# To use add to the local config:
# [filter "private"]
    # clean = ~/.local/bin/git-private.sh clean
    # smudge = ~/.local/bin/git-private.sh smudge
    # required = true
	#
# Add to local .gitattributes
# *.private filter=private
# can also add for specific files:
# tiny-irc/.config/tiny/config.yml filter=private
