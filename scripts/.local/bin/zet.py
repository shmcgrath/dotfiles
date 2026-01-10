#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import os
import argparse
import datetime
import json
import urllib.request

def getSecrets():
    try:
        import secrets
        darkSkyKey = secrets.DARK_SKY_KEY
        lat = secrets.DARK_SKY_LAT
        lon = secrets.DARK_SKY_LON
        journalDir = secrets.JOURNAL_DIR
        quickNotesDir = secrets.QUICK_NOTES_DIR
    except ImportError:
        print("Could not find secrets.py.")
        exit(1)

    if not darkSkyKey or not lat or not lon or not journalDir or not \
    quickNotesDir:
        print("required variable not found.")
        exit(1)

    return {
        'darkSkyKey': darkSkyKey,
        'lat': lat,
        'lon': lon,
        'journalDir': journalDir,
        'quickNotesDir': quickNotesDir,
    }

def getWeather(secrets):
    apikey = secrets['darkSkyKey']
    lat = secrets['lat']
    lon = secrets['lon']
    request = f"https://api.darksky.net/forecast/{apikey}" \
            f"/{lat},{lon}?exclude=minutely,hourly,alerts,flags"
    with urllib.request.urlopen(request) as response:
        data = json.loads(response.read().decode(response.info().get_param('charset') \
            or 'utf-8'))
    print(json.dumps(data, indent=4, sort_keys=True))

def zettelText(name, date, tags):
    zetText=f"---\ntitle: {name}\ndate: {date}\ntags: {tags}\n...\n\n# {name}\n"
    return zetText

def getTags(args):
    if args.tags is None:
        print("Enter zettel tags, starting each tag with # and separated",
        "by a space. Example: #tag1 #tag2 #tag3")
        tags = input("tags: ")
    elif args.tags is not None:
        tags = args.tags
    else:
        tags = "#notag"
    print(tags)
    return tags

def getName(args):
    if args.name is None:
        print("Enter zettel name.")
        name = input("name: ")
    elif args.name is not None:
        name = args.name
    else:
        name = "No name given"
    print(name)
    return name

def zettel(args, now):
    print("called zettel")
    datestr = f"{now:%Y-%m-%d %H:%M}"
    zetName = getName(args)
    zetTags = getTags(args)
    zetText = zettelText(zetName, datestr, zetTags)
    #print(zetText)


def quicknote(args, now):
    print("called quicknote")
    datestr = f"{now:%Y-%m-%d %H:%M}"

def journal(args, now):
    print("called journal")
    datestr = f"{now:%Y-%m-%d %H:%M}"

def main():
    secrets = getSecrets()
    for key, value in secrets.items():
        print(f"key:{key} value:{value}")
    now = datetime.datetime.now()
    print(secrets['darkSkyKey'])
    datestr = f"{now:%Y-%m-%d %H:%M}"
    filestr = f"{now:%Y%m%d%H%M}"
    NOTES = os.environ['NOTES']
    EDITOR = os.environ['EDITOR']
    print("NOTES environment variable value: {}".format(NOTES))
    print("EDITOR environment variable value: {}".format(EDITOR))
    print("Note to be saved as: {}".format(filestr))
    parser = argparse.ArgumentParser(description="Create a zettel.")
    parser.add_argument("-q", "--quicknote", help="create a quick zettel",
            action="store_true")
    parser.add_argument("-j", "--journal", help="create a journal",
            action="store_true")
    parser.add_argument("-t", "--tags", help="define tags")
    parser.add_argument("-n", "--name", help="provide Zettel name/title")
    args = parser.parse_args()
    print(args)
    getWeather(secrets)
    if args.quicknote:
        quicknote(args, now)
    elif args.journal:
        journal(args, now)
    else:
        zettel(args, now)

if __name__ == '__main__':
    main()
