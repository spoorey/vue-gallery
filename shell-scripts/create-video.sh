#!/bin/sh
# Workaround to ffmpeg bug: https://github.com/snapcrafters/ffmpeg/issues/41#issuecomment-533625390
echo 'creating video'
echo $(date +%Y-%m-%d-%H-%M)

#cat *.jpeg | ffmpeg -i pipe:0 -r 24 -f matroska pipe:1 | cat > output.avi
cat *.jpeg | ffmpeg -i pipe:0 -r 24 -c:v libvpx-vp9 -b:v 2M -f webm pipe:1 | cat > output.webm

rm timelapse.webm
mv output.webm timelapse.webm
