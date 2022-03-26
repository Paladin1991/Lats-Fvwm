#!/bin/bash

Time=`date '+%M'`

if (( "$Time" >= "00" )) && (( "$Time" <= "20" )); then
	echo "background-image: url('icons/calendar/img1.png')"
elif (( "$Time" > "20" )) && (( "$Time" < "40" )); then
	echo "background-image: url('icons/calendar/img2.png')"
else
	echo "background-image: url('icons/calendar/img3.png')"
fi