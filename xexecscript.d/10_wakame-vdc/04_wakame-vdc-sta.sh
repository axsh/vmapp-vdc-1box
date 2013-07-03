#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL <<EOS
  yum install -y wakame-vdc-sta-vmapp-config
  yum install -y wakame-vdc-example-1box-sta-vmapp-config
EOS
