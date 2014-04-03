#!/bin/bash

first_osd_id=$1
x=${first_osd_id}
for DEVICE in $( grep 3907018584 /proc/partitions | awk '{print $4}' );do
  echo 1024 > /sys/block/${DEVICE}/queue/read_ahead_kb
  echo 256 > /sys/block/${DEVICE}/queue/nr_requests
done

for SSD in $( grep 195360984 /proc/partitions | awk '{print $4}' );do
  # add tuning for journal ssds?
done
