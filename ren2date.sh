#!/bin/bash

folderfiles="$1"

for file in $(ls "$folderfiles"); do
    datetime=$(mediainfo $file | grep com.apple.quicktime.creationdate | head -n 1 | sed 's/ //g' | cut -d':' -f2-)
    if [ -z "$datetime" ]; then        
        datetime=$(mediainfo --Inform="Video;%Tagged_Date%" $file)
    fi
    if [[ ! -z "$datetime" ]]; then
        datename=$(date --date="$datetime" "+%Y%m%d-%H%M%S")
        newname=$folder/$datename"_"${file##*/}
        echo "$file --> $newname"
        mv "$file" "$newname"
    elif [[ ${file##*.} == "jpg" || ${file##*.} == "JPG" || ${file##*.} == "jpeg" || ${file##*.} == "JPEG" ]]; then
        jhead -n%Y%m%d-%H%M%S_%f $file
    else
        echo "No metadata for $file!"
    fi
done

