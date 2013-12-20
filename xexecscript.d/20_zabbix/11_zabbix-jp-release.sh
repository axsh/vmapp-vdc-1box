#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<EOS
 #rpm -Uvh http://repo.zabbix.jp/relatedpkgs/rhel6/x86_64/zabbix-jp-release-6-6.noarch.rpm
  rpm -Uvh http://repo.zabbix.com/zabbix/1.8/rhel/6/x86_64/zabbix-release-1.8-1.el6.noarch.rpm
EOS
