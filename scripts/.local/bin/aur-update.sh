#!/usr/bin/env bash

aurdir="$HOME/.aur/aur-pkgbuilds"
gitstat=""
for dir in $(ls "$aurdir"); do
    cd $aurdir/$dir
    git fetch
    gitstat="$(git status --branch --porcelain)"
    shortgitstat="${gitstat:0:2}"
    gitlog="$(git log -3 --oneline --decorate origin/master)"

    if [ $shortgitstat == "##" ]; then
        pkgstatus="up to date"
    else
        pkgstatus="not up to date"
        echo "$dir: $gitstat"
        read "would you like to see the diff (y/n)?" choice
        case "$choice" in
            y|Y ) message="Starting git diff";;
            n|N ) message="Ignoring diff";;
            * ) message="Invalid input";;
        esac

        if [ "${choice,,}" == "y" ]; then
            echo $message
            git diff ...remote/branch
        echo "----------"
        elif [ "${choice,,}" == "n" ]; then
            echo $message
        echo "----------"
        else
            echo $message
        echo "----------"
        fi
    fi

    function display_pkginfo {
        echo "$dir: $pkgstatus" 
        echo "$gitlog"
    }
    if [ "$pkgstatus" == "up to date" ]; then
        display_pkginfo
    else
        display_pkginfo
        read -p "Open PKGBUILD in $EDITOR? [y/n] " pkgbuildChoice
        case "$pkgbuildChoice" in
            [yY]* ) ${EDITOR:-${VISUAL:-vi}} PKGBUILD;;
            [nN]* );;
            * ) echo "Invalid selection; please answer yes (y) or no (n).";;
    esac
    fi
    echo "----------"
done
