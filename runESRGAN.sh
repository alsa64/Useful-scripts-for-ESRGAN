#!/bin/bash
shopt -s extglob

DIVIDER="------------------------------------------------"
SCALE="1"

for OPTION in "$@"; do
  case ${OPTION} in
    -s=*|--scale=*)
    SCALE="${OPTION#*=}"
    shift
    ;;
    *)
      echo "usage: $@ ..."
      echo "-s, --scale \"<number>\" (default: ${SCALE})"
      exit 1
    ;;
  esac
done

# Begin
# Change ESRGAN Scale
sed -i -e "s/upscale=[0-9]*/upscale="$SCALE"/g" ./esrgan/test.py

echo $DIVIDER
echo "Splitting Textures"
echo $DIVIDER
bash step1_create_tiles.sh --output-dir="./esrgan/LR"
echo $DIVIDER

# For each model
for file in ./esrgan/models/$SCALE/*.pth
do
    # Get filename and extention of the model
    MODELNAME=$(basename -- "$file")
    EXTENSION="${FILENAME##*.}"
    MODELNAME="${MODELNAME%.*}"

    # Go to esrgan directory
    pushd ./esrgan/

    echo $DIVIDER
    echo "Current model: "$MODELNAME
    echo $DIVIDER

    # Run ESRGAN
    python test.py ./models/$SCALE/$MODELNAME.pth

    # Go to previous directory
    popd

    echo $DIVIDER
    echo "reassemble"
    echo $DIVIDER


    # Recombine ESRGAN results and move them to a folder named after the model
    bash step3_assemble_tiles.sh --input-dir="./esrgan/results" --input-postfix="_rlt" --output-dir=./output/$SCALE/$MODELNAME

    # Remove ESRGAN results
    rm -rf ./esrgan/results/*
done

# Remove index of files and LR images
rm -rf ./esrgan/LR/*
rm -rf ./index.txt

echo $DIVIDER
echo "Done"
echo $DIVIDER
