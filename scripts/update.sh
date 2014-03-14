#!/bin/bash

cd /tmp/ceph-solo.git
git pull --rebase
sudo chef-solo -o 'recipe[ceph]'

