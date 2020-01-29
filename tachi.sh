#!/bin/bash
# Author : Samuel Waweru
# Alias  : sc13nt1st
# Date   : November 18th 2018
cd ~/Desktop/pdfTachistoscope/images
rm *.pdf && rm *.jpg
FILE=`zenity --file-selection` && cp "$FILE" .
mv *.pdf test.pdf
pdftoppm -jpeg test.pdf slide
rename 's\slide-000\slide_\' *.jpg
rename 's\slide-00\slide_\' *.jpg
rename 's\slide-0\slide_\' *.jpg
rename 's\-\_\' *.jpg
num2=$((`ls | wc -l`-1))
sed -i "25s/.*/numslides: $num2,/" ~/Desktop/pdfTachistoscope/js/directorySlider.js

# reverse renaming
mkdir renamed
num2=$((`ls | wc -l`-2))
prefix="slide_"
echo $prefix
declare -i num2
for i in $( eval echo {1..$num2} ); do
echo "slide_$i.jpg " "to" " $prefix$(( $num2 - $i + 1 )).jpg"
#mv "slide_$i.jpg" "$prefix$(( $num2 - $i + 1 )).jpg"
mv "slide_$i.jpg" "renamed/$prefix$(( $num2 - $i + 1 )).jpg"
#mv renamed/* .
done
mv renamed/* .
rm -r renamed/
