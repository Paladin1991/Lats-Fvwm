#!/bin/bash

open_sys(){

Eww=$(eww windows | grep system)

if [[ "$Eww" == "*system" ]]; then
    eww close system
else
    eww open system
fi

}

open_cal(){

Eww=$(eww windows | grep cal)

if [[ "$Eww" == "*cal" ]]; then
    eww close cal
else
    eww open cal
fi
}

open_spotify(){

Eww=$(eww windows | grep spotify)

if [[ "$Eww" == "*spotify" ]]; then
    eww close spotify
else
    eww open spotify
fi
}

case $1 in
    Sys) open_sys ;;
    Cal) open_cal ;;
    Spot) open_spotify ;;
esac
