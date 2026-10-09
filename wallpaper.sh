#!/usr/bin/bash
FOLDER=~/Pictures/wallpapers/
OUTPUT=~/Projects/scripts/wallpaper.txt
WALLPAPERPICK=$(ls $FOLDER | dmenu -l 20 -c)
CHOICE=${WALLPAPERPICK:-"error"}
wal -i ${FOLDER}${CHOICE}
xrdb -merge ~/.Xresources
xdotool key "Super_L+n"
if [ $CHOICE != "error" ]; then
  echo $WALLPAPERPICK > $OUTPUT
fi
