# Useful-scripts-for-ESRGAN
A few useful scripts when training using ESRGAN


For training:
valDiffToHR.sh:
  - This script will generate two images for each validation image. 
  - One that is the absolute difference to the HR image 
  - And one that is the normalized version of the absolute difference of the HR image. 
  - It needs to be in the folder of the validation image you want to generate the differences for (for example in basicsr/experiments/(model name)/(image name)) 
  - By default, it is configured to work with a ctp installation as Deorder recommends it.

rename.sh:
  - This script will rename all (.png files by default) to a number (with 4 digits by default).
  - Makes it easier to find validation images for example if they are all just a number.

runESRGAN.sh
  - This script will run ESRGAN with Deorder's scripts on all models with the scale of your choice. 
  - Add -s=(scale) to select the scale for ESRGAN.
  - Put all models in ./esrgan/models/(scale)/ for it to work
  - The output will be in ./output/(scale)/(modelname)
  - Put it in the ctp (Deorder's scripts directory)
