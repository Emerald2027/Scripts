#!/usr/bin/bash
WALLPAPER=$(cat ~/Projects/scripts/wallpaper.txt)
WALLPATH=~/Pictures/wallpapers/
feh --bg-scale ${WALLPATH}${WALLPAPER}
