#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex -ex <<EOS
  zabbix_version=1.8.16
  [[ -n "${zabbix_version}" ]] && {
    zabbix_version="-${zabbix_version}"
  }

  yum install -y \
     zabbix${zabbix_version} \
     zabbix-agent${zabbix_version}
EOS

chroot $1 $SHELL -ex -ex <<EOS
  chkconfig --list zabbix-agent
 #chkconfig zabbix-agent on
EOS
