#!/usr/bin/env bash

set -euo pipefail

PENDING_FILE="$HOME/Dropbox/single-file-urls-pending.txt"
DATE="$(date +"%Y-%m-%d-%H%M%S")"
ARCHIVE_FILE="$HOME/Dropbox/single-file-urls-imported-$DATE.txt"


if [ ! -f "$PENDING_FILE" ]; then
	printf 'Pending file does not exist: %s\n' "$PENDING_FILE"
	exit 1
fi

single-file \
	--urls-file "$PENDING_FILE" \
	--output-directory "$HOME/Dropbox/web-archive/" \
	--output-json false \
	--remove-hidden-elements true \
	--remove-unused-styles true \
	--remove-unused-fonts true \
	--remove-frames false \
	--block-fonts false \
	--block-images false \
	--save-raw-page false \
	--compress-html false \
	--insert-text-body true \
	--embed-screenshot false \
	--embed-pdf false \
	--compress-css false \
	--move-styles-in-head false \
	--load-deferred-images true \
	--load-deferred-images-max-idle-time 1500 \
	--load-deferred-images-keep-zoom-level false \
	--load-deferred-images-dispatch-scroll-event false \
	--load-deferred-images-before-frames false \
	--filename-template "%lowercase<%trim<%if-empty<%substring<{page-title}|0|50>|%substring<{url-pathname-flat}|0|50>>>>-{url-hostname-domain}-{datetime-iso}.{filename-extension}" \
	--filename-replacement-character "-" \
	--replace-emojis-in-filename true \
	--include-infobar true \
	--compress-content false \
	--create-root-directory false \
	--prevent-appended-data false \
	--self-extracting-archive false \
	--extract-data-from-page false \
	--infobar-template "\nPage Title: {page-title}\nPage H1: {page-heading}\nPage Language: {page-language}\nPage Description: {page-description}\nPage Author: {page-author}\nPage Creator: {page-creator}\nPage Publisher: {page-publisher}\nSave Date and Time ISO: {datetime-iso}\nSave Date and Time UTC: {datetime-utc}\nSave Date and Time Locale: {datetime-locale}\nSave Date ISO: {date-iso}\nSave Time ISO: {time-iso}\nSame Time ms Since Unix Epoch: {time-ms}\nVisit Date and Time ISO: {visit-datetime-iso}\nVisit Date and Time UTC: {visit-datetime-utc}\nVisit Date and Time Locale: {visit-datetime-locale}\nVisit Date ISO: {visit-date-iso}\nVisit Time ISO: {visit-time-iso}\nURL: {url-href}\nSHA-1 Hash Value of URL: {url-href-digest-sha-1}\nURL Flat: {url-href-flat}\nURL Path Name: {url-pathname}\nURL Path Name Flat: {url-pathname-flat}\nURL Last Segment: {url-last-segment}\nURL Protocol: {url-protocol}\nURL Host: {url-host}\nURL Host Name: {url-hostname}\nURL Host Name Suffix: {url-hostname-suffix}\nURL Host Name Domain: {url-hostname-domain}\nURL Host Name Root: {url-hostname-root}\nURL Host Name Subdomains: {url-hostname-subdomains}\nURL Port: {url-port}\nURL Username: {url-username}\nURL Password: {url-password}\nURL Search String: {url-search}\nURL Hash: {url-hash}\nURL Referrer: {url-referrer}\nURL Referrer Flat: {url-referrer-flat}\nURL Original: {url-original}\nBookmark Pathname: {bookmark-pathname}\nBookmark Pathname Flat: {bookmark-pathname-flat}\nBrowser Language: {navigator-language}\nTab ID: {tab-id}\nTab Index: {tab-index}\nSHA-256 Hash Value of Page Content: {digest-sha-256}\nSHA-384 Hash Value of Page Content: {digest-sha-384}\nSHA-512 Hash Value of Page Content: {digest-sha-512}\nProfile Name Used to Save Page: {profile-name}\nFilename Extension: {filename-extension}\nSave Action: {save-action}\nSHM Tags:" \
	--block-mixed-content false \
	--save-original-urls true \
	--include-infobar true \
	--open-infobar false \
	--remove-saved-date false \
	--filename-replaced-character "[ " \
	--filename-replaced-character "] " \
	--filename-replaced-character "{ " \
	--filename-replaced-character "} " \
	--filename-replaced-character "( " \
	--filename-replaced-character ") " \
	--filename-replaced-character "< " \
	--filename-replaced-character "> " \
	--filename-replaced-character ", " \
	--filename-replaced-character "# " \
	--filename-replaced-character "~ " \
	--filename-replaced-character "+ " \
	--filename-replaced-character "? " \
	--filename-replaced-character "% " \
	--filename-replaced-character "* " \
	--filename-replaced-character ": " \
	--filename-replaced-character "| " \
	--filename-replaced-character "! " \
	--filename-replaced-character "\" " \
	--filename-replaced-character "\\\\ " \
	--filename-replaced-character "\\x00-\\x1f " \
	--filename-replaced-character "\u0000-\u001f " \
	--filename-replaced-character " " \
	--filename-replaced-character "-- -" \
	--filename-replaced-character "--- -" \
	--filename-replaced-character "__ _" \
	--filename-replaced-character "___ _" \
	--filename-replaced-character "\s -" \
	--resolve-links true \
	--user-script-enabled false \
	--include-bom false \
	--insert-single-file-comment true \
    --infobar-position-absolute false \
    --infobar-position-top "16px" \
    --infobar-position-right "16px" \
    --infobar-position-bottom "" \
    --infobar-position-left ""

mv -- "$PENDING_FILE" "$ARCHIVE_FILE"

printf 'Archived:\n%s\n\n' "$ARCHIVE_FILE"

touch -- "$PENDING_FILE"

printf 'Created new pending file:\n%s\n' "$PENDING_FILE"

# DO I WANT USER SCRIPT Y OR NO MAY CHANGE
# LOOK INTO CRAWL LINKS
# Defaults I am not passing
# --block-scripts true \
# --block-videos true \
# --block-audios true \
# --block-stylesheets false \
# --accept-header-document "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
# --accept-header-script "*/*" \
# audio header flag missing
# video header flag missing
# --accept-header-font "application/font-woff2;q=1.0,application/font-woff;q=0.9,*/*;q=0.8" \
# --accept-header-stylesheet "text/css,*/*;q=0.1" \
# --accept-header-image "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8" \
# --insert-meta-CSP true \
# --group-duplicate-stylesheets false \
# --filename-conflict-action uniquify \
# --filename-max-length 192 \
# --filename-max-length-unit bytes \
# --remove-alternative-fonts true \
# --remove-alternative-images true \
# --remove-alternative-medias true \
# --group-duplicate-images true \
# --max-size-duplicate-images 524288 \
# --max-parallel-workers 8 \
# --block-alternative-images true \
# --remove-no-script-tags true \
