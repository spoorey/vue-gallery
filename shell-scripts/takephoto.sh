#!/bin/bash
# Available Controls        Current Value   Range
# ------------------        -------------   -----
# Brightness                12 (59%)        -64 - 64
# Contrast                  48 (75%)        0 - 64
# Saturation                68 (53%)        0 - 128
# Hue                       0 (50%)         -40 - 40
# Gamma                     108 (8%)        72 - 500
# Gain                      0 (0%)          0 - 100
# Power Line Frequency      60 Hz           Disabled | 50 Hz | 60 Hz
# Sharpness                 2               0 - 6
# Backlight Compensation    1               0 - 2
# Exposure, Auto Priority   True            True | False
echo 'take photo'
cd $(dirname "$0")
echo $(date +%Y-%m-%d-%H-%M)

fswebcam -r 1600x1200 --jpeg 100 -D 4 -S 13 -F 8  $(date +%Y-%m-%d-%H-%M).jpeg

echo 'photo taken, updating json'

files=""
for f in *.jpeg
do
    files="\"$f\",$files"
done
files=${files::-1}
files="[$files]"

echo $files > images.json

