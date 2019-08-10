#!/bin/sh

URL="$1"
TITLE="$2"
DESCRIPTION="$3"
FEED_TITLE="$4"
EXTENDED="Description: ${DESCRIPTION} Feed: ${FEED_TITLE}"

echo -e "[${TITLE}](${URL})${DESCRIPTION}\t${FEED_TITLE}" >> ~/bookmarks.txt
