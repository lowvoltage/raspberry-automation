#!/bin/bash

# Based on:
# https://linuxconfig.org/how-to-mount-rasberry-pi-filesystem-image

# Double check the supplied file's extension
if [ $# -eq 0 ]
  then
    echo "No filename supplied"
    exit 1
fi

if [[ $1 != *.img ]]
  then
    echo "$1 is not an .img file"
    exit 1
fi

# Create a temp folder for the mount
tmp_dir=$(mktemp -d -t rpi_boot_XXXX)

# Mount the first partition from the .IMG file
mount $1 -o loop,offset=$(( 512 * 8192)) $tmp_dir

# Create an empty `ssh` file on the mounted image
touch $tmp_dir/ssh

# Cleanup: Unmount
umount $tmp_dir

# Cleanup: Remove folder
rm -rf $tmp_dir

