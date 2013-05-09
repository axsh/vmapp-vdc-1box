#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL <<EOS
  chkconfig httpd on
  chown apache:apache /var/lib/wakame-vdc/images
EOS
