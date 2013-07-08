#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL <<'EOS'
  $(rpm -ql td-agent | grep ruby/bin/fluent-gem) install cassandra -v 0.17.0 --no-ri --no-rdoc
EOS
