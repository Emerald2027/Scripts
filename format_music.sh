#!/usr/bin/bash

shopt -s nullglob

TARGET_DIR="${1:-.}"
formattedFolder=""
for file in "$TARGET_DIR"/*; do
  [ -f "$file" ] || continue
  ext="${file##*.}"
  ext="${ext,,}"
  if [[ $ext == "wav" || $ext == "flac" || $ext == "ogg" || $ext == "mp3" ]]; then
    title="$(ffprobe -v error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$file")"
    title=${title//\//-}
    artist="$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$file")"
    artist=${artist//\//-}
    num1="$(ffprobe -v error -show_entries format_tags=track -of default=noprint_wrappers=1:nokey=1 "$file")"
    num1=${num1%%/*}
    year="$(ffprobe -v error -show_entries format_tags=date -of default=noprint_wrappers=1:nokey=1 "$file")"
    year=${year:0:4}
    album="$(ffprobe -v error -show_entries format_tags=album -of default=noprint_wrappers=1:nokey=1 "$file")"
    album=${album//\//-}

    if [ -z "$title" ] || [ -z "$artist" ] || [ -z "$album" ]; then
      echo "skipping (missing tags): $file" >&2
      continue
    fi

    printf -v num2 "%02d" "$((10#${num1:-0}))"
    name=${artist// /_}-${num2}-${title// /_}.${ext}
    formattedName=${name,,}
    folder=${artist// /_}/${album// /_}\(${year}\)
    formattedFolder=/home/alice/Music/songs/"${folder,,}"
    mkdir -p "${formattedFolder}"
    echo "moving song to path " "${formattedFolder}"/"${formattedName}"
    mv -n -- "${file}" "${formattedFolder}"/"${formattedName}"
  fi
done

for file in "$TARGET_DIR"/*; do
  [ -n "$formattedFolder" ] || break 
  [ -f "$file" ] || continue
  ext="${file##*.}"
  ext="${ext,,}"
  if [[ $ext == "pdf" || $ext == "jpg" || $ext == "png" ]]; then
    mv -n -- "${file}" "${formattedFolder}"
  fi
done
echo "done!"
