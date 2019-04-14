#!/bin/bash

SEARCHEXTENTION="jpg"
RESULTSUFFIX=""
RESULTPREFIX="downscaled_"
RESULTEXTENTION="png"
FILTER="box"

for file in *.$SEARCHEXTENTION
do

FILENAME=${file%.*}

OW="`magick identify -format %w $file`"
OH="`magick identify -format %h $file`"
OQ="`magick identify -format %Q $file`"

DIVISOR=4

if [ $SEARCHEXTENTION = "jpg" ]
then
    if [ $OQ -gt 90 ]
    then
        DIVISOR=4
    else
        if [ $OQ -gt 25 ]
        then
            DIVISOR=8
        else
            DIVISOR=16
    fi
fi

NW=$(($OW/$DIVISOR))
NH=$(($OH/$DIVISOR))

if [ $SEARCHEXTENTION = "jpg" ]
then
    echo $file "(Quality:"$OQ") originally "$OW" x "$OH" will be downscaled to "$NW" x "$NH" (divided by "$DIVISOR") with "$FILTER" filtering."
else
    echo $file" originally "$OW" x "$OH" will be downscaled to "$NW" x "$NH" (divided by "$DIVISOR") with "$FILTER" filtering."
fi

magick convert $file -filter $FILTER -resize $NW"x"$NH $RESULTPREFIX$FILENAME$RESULTSUFFIX.$RESULTEXTENTION

done
