# ren2date

## Description
A simple bash script to rename all .jpg images and videos in a folder by prefixing the date taken/recorded in the format: `YYYYMMDD-HHMMSS-<original filename>`

The script uses `jhead`(jpeg) and `mediainfo` (video) tools to retrieve metadata from files.

## Usage

```
./ren2date.sh "path-to-files/*"
./ren2date.sh "path-to-files/*.jpg"
./ren2date.sh "path-to-files/*.mp4"
./ren2date.sh "path-to-files/*.mov"
```

### Output
```
IMG12345.jpg --> 20220812-132404_IMG1234.jpg
VID54321.mp4 --> 20220815-104512_VID54321.mp4
```