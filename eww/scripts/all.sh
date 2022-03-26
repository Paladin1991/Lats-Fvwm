#!/bin/bash

function CPU(){
	read cpu a b c previdle rest < /proc/stat
  		prevtotal=$((a+b+c+previdle))
  		sleep 0.5
  			read cpu a b c idle rest < /proc/stat
  			total=$((a+b+c+idle))
  			cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ));

  echo "$cpu"
}

function MEM(){
	echo "`free | grep Mem | awk '{print $3/$2 * 100.0}' | awk '{print int($1+0.5)}'`"
}

function Root(){
  echo "`du -hcs / 2> /dev/null`" | sed -n 1p | cut  -d "G" -f1
}

function Home(){
  echo "`du -hcs /home 2> /dev/null`" | sed -n 1p | cut  -d "G" -f1
}


function VOL() {
  amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%'
}

function MIC() {
  amixer | grep "Front Left: Capture" | awk -F'[][]' '{ print $2 }' | tr -d '%'
}

function Mic_Icon() {
  Status_Mic=$(amixer | grep "Front Left: Capture" | awk '{print $6}' | sed 's/]//g;s/\[//g')
  if [[ $Status_Mic = on ]]; then
    echo "icons/mic.svg"
  else
    echo "icons/mic-mut.svg"
  fi
}

function Volume_Icon() {
  Status_Vol=$(amixer | grep Left | sed -n 2p | cut -d "[" -f3 | sed 's/]//g')
  if [[ $Status_Vol = on ]]; then
    echo "icons/volume.svg"
  else
    echo "icons/muted.svg"
  fi
}

TEMP1(){
  echo "`sensors | grep temp1 | awk '{print $2}' | sed "s/[+C°]//g"`"
}

TEMP2(){
  echo "`sensors | grep temp2 | awk '{print $2}' | sed "s/[+C°]//g"`"
}

case $1 in
	Cpu) CPU ;;
	Mem) MEM ;;
	Disc1) Root;;
  Disc2) Home;;
	Vol) VOL ;;
	Mic) MIC ;;
	MicIcon) Mic_Icon ;;
	VolIcon) Volume_Icon ;;
  Temp1) TEMP1 ;;
  Temp2) TEMP2 ;;
esac