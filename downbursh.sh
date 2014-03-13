#!/bin/bash
VM_NAME=$1
/tmp/downburst/virtualenv/bin/downburst -c qemu:///system create ${VM_NAME} --user-data=/tmp/downburst/doc/examples/rbd.user.yaml
