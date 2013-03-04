#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

# dcmgr
chroot $1 $SHELL <<EOS
yum install -y wakame-vdc-dcmgr-vmapp-config
yum install -y wakame-vdc-admin-vmapp-config
EOS
