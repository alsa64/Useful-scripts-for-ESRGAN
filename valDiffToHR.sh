#!/bin/bash

# User Changable Variables:
PATH_TO_HR_DIR="../../../../../training/output_validation/HR"
PREFIX_FOR_DIFF=""
SUFFIX_FOR_DIFF="_diffToHR"
PREFIX_FOR_DIFF_NORMALIZED=""
SUFFIX_FOR_DIFF_NORMALIZED="_diffToHR_Normalized"
FILETYPE_RESULT="png"

# the prefix required for ImageMagick to work, version 7 merged convert, identify, ... into magick, so magick must be added befere all IM commands for all other versions it will remain empty
if [ -x "$(command -v magick)" ]; then
    MAGICK_COMMAND="magick "
else
    MAGICK_COMMAND=""
fi

for file in *.png
do
    FILENAME=$(basename -- "$file")
    EXTENSION="${FILENAME##*.}"
    FILENAME="${FILENAME%.*}"
    ITERATION=`echo ${FILENAME} | cut -d_ -f2`
    HR_IMAGE_NAME="`echo ${file} | cut -d_ -f1`"

    # Log
    echo "File:"$file" ImageName:"$HR_IMAGE_NAME" Iteration:"$ITERATION

    # Create difference
    $MAGICK_COMMAND"convert" $file $PATH_TO_HR_DIR/$HR_IMAGE_NAME.png  -compose difference -composite $PREFIX_FOR_DIFF$FILENAME$SUFFIX_FOR_DIFF.$FILETYPE_RESULT

    # Normalize difference
    $MAGICK_COMMAND"convert" $FILENAME"_diffToHR.png" -auto-level $PREFIX_FOR_DIFF_NORMALIZED$FILENAME$SUFFIX_FOR_DIFF_NORMALIZED.$FILETYPE_RESULT
done
