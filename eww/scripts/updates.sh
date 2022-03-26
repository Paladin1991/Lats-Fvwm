#!/bin/bash

ups=$(checkupdates | wc -l 2>/dev/null)

if [[ $ups > 0 ]]; then
    echo "icons/bar/updates-now.svg"
else
	echo "icons/bar/updates.svg"
fi

case $1 in
	Upgrade) 
			if [[ $ups > 0 ]]; then
				kitty -e sudo pacman -Syyuu
			else
				notify-send "Not packages to upgrade"
			fi
esac