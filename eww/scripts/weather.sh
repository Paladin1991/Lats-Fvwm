#!/bin/bash

case $1 in
	city) curl wttr.in/?format="%l\n" ;;
	temp) curl wttr.in/?format="%f\n" ;;
	icon) curl wttr.in/?format="%c\n" ;;
esac