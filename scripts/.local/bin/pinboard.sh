#!/bin/sh

#URL="$1"
#TITLE="$2"
#DESCRIPTION="$3"
#FEED_TITLE="$4"

#URL="http://grantland.com/features/the-consequences-caring/"
#URL="https://www.tifofootball.com/features/unexpected-journeys-when-fulham-danced-with-europes-best/"
URL="https://www.si.com/nfl/2019/06/13/kellen-winslow-jr-ii-crimes-rape-trial-homeless-woman-elderly"
TITLE="Unexpected Journeys: When Fulham danced with Europe’s best"
EXTENED="Unexpected Journeys : Chapter 6 Words By Sean Cole Illustration by Philippe Fenner May 28, 2019"
TAGS="socer fulhamfc"

BASE_URL="https://api.pinboard.in/v1"
AUTH_TOKEN=""

ARTICLE_DETAILS=$(curl -s ${URL} | grep -C0 -Eo '(<title>.*</title>)|(<link rel="canonical".*href=".*".*>)|(<(meta|span) (class|name)=[[:punct:]]author)|(<meta name="description" content=".*)|(<meta (name|property)="[[:alpha:]]*[\.:]*(author|date|description|.*keywords|site_name|tag|tags|title|.*time|url)" content=".*".*>)' | sed )

echo "$ARTICLE_DETAILS"

#TITLE_GREP=$($ARTICLE_DETAILS | grep -C0 -E 'title')
TITLE_GREP=$ARTICLE_DETAILS

print $TITLE_GREP


#print "Enter comma separated tags for the bookmark: "
#read TAGS

#print "Author: "
#read AUTHOR

#print "Date published: "
#read DATE_PUBLISHED

#print "Article Name: "
#read ARTICLE_NAME

#print "Site: "
#reaad SITE

#print "Detailed tags (comma separated): "
#read TAGS_DETAILEDo

#print "Read later (y/n): "
#read READ_LATER

#print "Private (y/n): "
#read PRIVATE
