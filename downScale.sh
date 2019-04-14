#!/bin/bash

# What images should be processed:
SEARCHEXTENTION="jpg"
# Text after the new filename:
RESULTSUFFIX=""
# Text before the new filename:
RESULTPREFIX="downscaled_"
# File type for the result:
RESULTEXTENTION="png"
# Downscaling Filter:
FILTER="box"
# Set this to the title size you use for training:
TARGETDIVIDABLEBY=128
# The default divisor, only used if the file that gets processed isn't a jpg:
DIVISOR=4

for file in *.$SEARCHEXTENTION
do
    FILENAME=${file%.*}
    # 
    OW="`magick identify -format %w $file`"
    OH="`magick identify -format %h $file`"
    
    # Set divisors depending on jpg quality:
    if [ $SEARCHEXTENTION = "jpg" ]
    then
        OQ="`magick identify -format %Q $file`"
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
    # Calculate Dimensions
    CW=$(($OW/$DIVISOR*$DIVISOR))
    CH=$(($OH/$DIVISOR*$DIVISOR))

    NW=$(($CW/$DIVISOR))
    NH=$(($CH/$DIVISOR))

    RW=$(($NW/$TARGETDIVIDABLEBY*$TARGETDIVIDABLEBY))
    RH=$(($NH/$TARGETDIVIDABLEBY*$TARGETDIVIDABLEBY))
    # Log
    if [ $SEARCHEXTENTION = "jpg" ]
    then
        echo $file "(Quality:"$OQ") originally "$OW" x "$OH" will be downscaled to "$NW" x "$NH" (divided by "$DIVISOR") with "$FILTER" filtering."
    else
        echo $file" originally "$OW" x "$OH" will be downscaled to "$NW" x "$NH" (divided by "$DIVISOR") with "$FILTER" filtering."
    fi
    # Crop image to prepare for downscaling, neccessary for box filter:
    magick convert $file -crop $CW"x"$CH+0+0 tmp_$FILENAME.$RESULTEXTENTION
    # Downscale image
    magick mogrify  tmp_$FILENAME.$RESULTEXTENTION -filter $FILTER -resize $NW"x"$NH
    # Make the result dividable through the targetdivisor
    magick convert tmp_$FILENAME.$RESULTEXTENTION -crop $CW"x"$CH+0+0 $RESULTPREFIX$FILENAME$RESULTSUFFIX.$RESULTEXTENTION
    # Remove temporary files
    rm -f tmp_*
done