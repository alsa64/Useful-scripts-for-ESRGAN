# Usefull-scripts-for-ESRGAN
A few useful scripts when training using ESRGAN


For training:
valDiffToHR.sh:
  - this script will generate two images for each validation image. One that is the absolute difference to the HR image and one that is the normalized version of the absolute difference of the HR image. It needs to be in the folder of the validation image you want to generate the differences for (in basicsr/experiments/(model name)/(image name>)) By default it is configured to work with a ctp installation as Deorder recommends it.
