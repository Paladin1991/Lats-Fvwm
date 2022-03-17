#!/bin/sh

POP=$(cat ~/.zshrc | grep PS1 | cut -d "'" -f2 | cut -d '(' -f2 | sed 's/)//g')

# Colors Generator

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
b=$'\e[1m' # bold
e=$'\e[0m' # end color

load(){
	for i in Loading . . . . . . . . .; do
		echo -ne "\b $i \c \n"; sleep 0.3
	done
}

applying(){
	for i in Applying . . . . . . . . .; do
		echo -ne "\b $i \c \n"; sleep 0.3
	done
}

# Initial Layout
init_lay(){
clear
load
clear

cat << EOF
${f2}▀█$e █▀█ █▀█ █▀█ ${f2}━━━━━━━━━━━━━━━━━━━$e
${f2}█▄$e █▀▀ █▄█ █▀▀ ${f2}Select your ${f1}Z ${f2}theme$e
${f2}━━━━━━━━━━━━━━$e

${f5}1${e}) Candy 
${f5}2${e}) Ice cream 
${f5}3${e}) Simple
${f5}4${e}) Colorise
${f5}5${e}) Here
${f5}6${e}) Happy

${f5}e${e}) Exit

EOF

read -e -p "Select your theme: " opc

	case $opc in
		e) exit 1 ;;
		1) sed -i "s/$POP/candy/g" ~/.zshrc ;;
		2) sed -i "s/$POP/icecream/g" ~/.zshrc ;;
		3) sed -i "s/$POP/simple/g" ~/.zshrc ;;
		4) sed -i "s/$POP/colorise/g" ~/.zshrc ;;
		5) sed -i "s/$POP/here/g" ~/.zshrc ;;
		6) sed -i "s/$POP/happy/g" ~/.zshrc ;;
	esac

clear
applying
clear
zsh
}

init_lay