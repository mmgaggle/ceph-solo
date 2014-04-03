#!/bin/bash

# Create and label data partitions
first_osd_id=$1
x=${first_osd_id}
for DEVICE in $( grep 3907018584 /proc/partitions | awk '{print $4}' );do
  sudo parted -sa optimal /dev/${DEVICE} rm 1
  sudo parted -sa optimal /dev/${DEVICE} mklabel gpt
  sudo parted -sa optimal /dev/${DEVICE} mkpart osd-device-$x-data 0% 100%
  sudo mkfs.xfs -f -i size=2048 /dev/${DEVICE}1
  let "x++"
  sudo sfdisk -R /dev/${DEVICE}
done

for SSD in $( grep 195360984 /proc/partitions | awk '{print $4}' );do
  sudo parted -sa optimal /dev/${SSD} rm 1
  sudo parted -sa optimal /dev/${SSD} rm 2
  sudo parted -sa optimal /dev/${SSD} rm 3
  sudo parted -sa optimal /dev/${SSD} rm 4
  sudo parted -sa optimal /dev/${SSD} rm 5
  sudo parted -sa optimal /dev/${SSD} mklabel gpt
  sudo parted -sa optimal /dev/${SSD} mkpart osd-device-$y-journal 0G 10G
  let "y++"
  sudo parted -sa optimal /dev/${SSD} mkpart osd-device-$y-journal 10G 20G
  let "y++"
  sudo parted -sa optimal /dev/${SSD} mkpart osd-device-$y-journal 20G 30G
  let "y++"
  sudo parted -sa optimal /dev/${SSD} mkpart osd-device-$y-journal 30G 40G
  let "y++"
  sudo parted -sa optimal /dev/${SSD} mkpart osd-device-$y-journal 40G 50G
  sudo sfdisk -R /dev/${SSD}
done
