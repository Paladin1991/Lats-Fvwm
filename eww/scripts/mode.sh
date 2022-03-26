#!/bin/bash

# Global variables
kitty_dir=~/.config/kitty/kitty.conf
gtk_dir=~/.config/gtk-3.0/settings.ini
eww_dir=~/.config/eww/themes/colors.scss
rofi_dir=~/.config/rofi/config.rasi
fvwm_dir=~/.fvwm/themerc
FvwmTheme=$(cat ~/.fvwm/themerc | grep MenuColorset | cut -d "." -f2 | sed 's/]//g')

mode=$(cat ~/.config/eww/themes/colors.scss | grep base | cut -d "#" -f2 | cut -d "," -f1)

Mode(){
		if [[ $mode == 1E1E28 ]]; then
			cat ~/.config/kitty/midnight-light > $kitty_dir
			cat ~/.config/eww/themes/midnight-light.scss > $eww_dir
			echo '@import "midnight-light.rasi"' > $rofi_dir
			sed -i 's/Midnight/Midnight-Light/g' $gtk_dir
			sed -i 's/FFFFFF/100e10/g' ~/.config/eww/icons/bar/*.svg
			sed -i 's/FFFFFF/100e10/g' ~/.config/eww/icons/music/*.svg
			sed -i 's/FFFFFF/100e10/g' ~/.config/eww/icons/net/*.svg
			sed -i 's/FFFFFF/100e10/g' ~/.config/eww/icons/power/*.svg
			sed -i "s/$FvwmTheme/Base-White/g" $fvwm_dir
            sed -i "s/Border-Dark/Border-White/g" $fvwm_dir
			sed -i "s/FFFFFF/121212/g" ~/.fvwm/icons/titlebar/tri/*.svg
			sed -i 's/FFFFFF/121212/g' ~/.fvwm/icons/titlebar/circle/*.svg
            sed -i 's/FFFFFF/121212/g' ~/.fvwm/icons/titlebar/classic/*.svg
            sed -i 's/FFFFFF/121212/g' ~/.fvwm/icons/menu/*.svg
		else
			cat ~/.config/kitty/midnight > $kitty_dir
			cat ~/.config/eww/themes/midnight.scss > $eww_dir
			echo '@import "midnight.rasi"' > $rofi_dir
			sed -i 's/Midnight-Light/Midnight/g' $gtk_dir
			sed -i 's/100e10/FFFFFF/g' ~/.config/eww/icons/bar/*.svg
			sed -i 's/100e10/FFFFFF/g' ~/.config/eww/icons/music/*.svg
			sed -i 's/100e10/FFFFFF/g' ~/.config/eww/icons/net/*.svg
			sed -i 's/100e10/FFFFFF/g' ~/.config/eww/icons/power/*.svg
			sed -i "s/$FvwmTheme/Base-Dark/g" $fvwm_dir
            sed -i "s/Border-White/Border-Dark/" $fvwm_dir
			sed -i "s/121212/FFFFFF/g" ~/.fvwm/icons/titlebar/tri/*.svg
			sed -i 's/121212/FFFFFF/g' ~/.fvwm/icons/titlebar/circle/*.svg
			sed -i 's/121212/FFFFFF/g' ~/.fvwm/icons/titlebar/classic/*.svg
            sed -i 's/121212/FFFFFF/g' ~/.fvwm/icons/menu/*.svg
		fi
}

Icon(){
		if [[ $mode == 1E1E28 ]]; then
			echo "icons/bar/light.svg"
		else
			echo "icons/bar/dark.svg"
		fi
}

case $1 in
1) Mode
   FvwmCommand "Restart"
   exit 0
   ;;
2) Icon
esac


