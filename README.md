# ren2date

A simple bash script to rename all .jpg images and videos in a folder by prefixing the date taken/recorded in the format: `YYYYMMDD-HHMMSS-<original filename>`

The script uses `jhead`(jpeg) and `mediainfo` (video) tools to retrieve metadata from files.