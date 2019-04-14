# Useful-scripts-for-ESRGAN
A few useful scripts when training using ESRGAN


# For training:

valDiffToHR.sh:
  - This script will generate two images for each validation image. 
  - One that is the absolute difference to the HR image 
  - And one that is the normalized version of the absolute difference of the HR image. 
  - It needs to be in the folder of the validation image you want to generate the differences for (for example in basicsr/experiments/(model name)/(image name)) 
  - By default, it is configured to work with a ctp installation as Deorder recommends it.

rename.sh:
  - This script will rename all (.png files by default) to a number (with 4 digits by default).
  - Makes it easier to find validation images for example, if they are all just a number.
  - Put it where the files you want to rename are.

downScale.sh:
  - This script will downscale all (.jpg files by default) by 4, 8 or 16 depending on the Quality of them.
  - If you change the script to use something else than jpg (like png for example), it will always downscale it by a factor of 4 (can be changed)
  - This is useful if you can't find any lossless images for training ESRGAN in the case of jpg files.
  - It utilizes the box filter, which can also be used to perform Pixel binning, since it averages pixels in each "box" instead of using just one of them like Nearest Neighbor would, preserving Detail and Sharpness.
  - the script is fully commented

# For using ESRGAN

runESRGAN.sh
  - This script will run ESRGAN with Deorder's scripts on all models with the scale of your choice. 
  - Add -s=(scale) to select the scale for ESRGAN.
  - Put all models in ./esrgan/models/(scale)/ for it to work
  - The output will be in ./output/(scale)/(modelname)
  - Put it in the ctp (Deorder's scripts directory)
