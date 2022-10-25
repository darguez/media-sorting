#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 [rename|touch|test] \"path-to-files/*\""
    exit 0
fi

mode="$1"
folderfiles="$2"

for file in $(ls $folderfiles); do
    if [[ ${file##*.} == "jpg" || ${file##*.} == "JPG" || ${file##*.} == "jpeg" || ${file##*.} == "JPEG" ]]; then
        if [ $mode == "rename" ]; then
            jhead -n%Y%m%d-%H%M%S_%f $file
        elif [ $mode == "touch" ]; then
            jhead -ft $file
        else
            datetime=$(jhead $file | grep Date/Time | head -n 1 | cut -d':' -f2- | cut -d' ' -f2- | sed "s/\:/\-/" | sed "s/\:/\-/")
            echo "$file --> exif date: $datename"
        fi
    else #video file
        datetime=$(mediainfo $file | grep com.apple.quicktime.creationdate | head -n 1 | sed 's/ //g' | cut -d':' -f2-)
        if [ -z "$datetime" ]; then
            datetime=$(mediainfo --Inform="Video;%Tagged_Date%" $file)
        fi
        if [[ ! -z "$datetime" ]]; then
            datename=$(date --date="$datetime" "+%Y%m%d-%H%M%S")
            touchdate=$(date --date="$datetime" "+%Y%m%d%H%M.%S")
            newname=$folder/$datename"_"${file##*/}
            if [ $mode == "rename" ]; then
                echo "$file --> $newname"
                mv "$file" "$newname"
            elif [ $mode == "touch" ]; then
                echo "$file --> new accessed/modified date: $touchdate"
                touch -m -a -t $(date --date="$datetime" "+%Y%m%d%H%M.%S") $file
            else
                echo "$file --> exif date: $datename"
            fi
        fi
    fi
    if [ -z "$datetime" ]; then
        echo "No metadata for $file!"
    fi
done
