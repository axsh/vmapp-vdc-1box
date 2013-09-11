#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<EOS
  yum install -y \
     td-agent-1.1.13
EOS

chroot $1 $SHELL -ex <<EOS
  chkconfig --list td-agent
  chkconfig td-agent on
  chkconfig --list td-agent
EOS
