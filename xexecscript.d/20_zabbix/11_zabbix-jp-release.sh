#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<EOS
  rpm -Uvh http://repo.zabbix.jp/relatedpkgs/rhel6/x86_64/zabbix-jp-release-6-6.noarch.rpm
EOS
