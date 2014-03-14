#!/bin/bash
echo " + stopping /dev/md0"
sudo mdadm --manage /dev/md0 -S

echo " + removing /dev/md0"
sudo mdadm --manage /dev/md0 -r

echo " + removing gpt partitions"
for i in $( grep 3907018584 /proc/partitions | awk '{print $4}' );do 
  sudo /bin/dd if=/dev/zero of=/dev/$i bs=512 count=34 skip=3907029134
done

echo " + tell kernel to re-read partition tables"
for i in $( grep 3907018584 /proc/partitions | awk '{print $4}' );do
  sudo sfdisk -R /dev/$i
done

