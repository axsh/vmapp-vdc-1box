#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL <<EOS
  rpm -Uvh http://dlc.wakame.axsh.jp.s3-website-us-east-1.amazonaws.com/epel-release

  yum clean metadata --disablerepo=* --enablerepo=wakame-vdc-rhel6
  yum update  -y     --disablerepo=* --enablerepo=wakame-vdc-rhel6
EOS
