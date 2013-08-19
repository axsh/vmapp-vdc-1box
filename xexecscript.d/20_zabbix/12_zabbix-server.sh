#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<EOS
  zabbix_version=1.8.16
  [[ -n "${zabbix_version}" ]] && {
    zabbix_version="-${zabbix_version}"
  }

  yum install -y \
     zabbix${zabbix_version} \
     zabbix-server${zabbix_version} \
     zabbix-server-mysql${zabbix_version} \
     zabbix-web${zabbix_version} \
     zabbix-web-mysql${zabbix_version}
EOS

chroot $1 $SHELL -ex <<EOS
  chkconfig --list zabbix-server
  chkconfig zabbix-server on
EOS

cat <<EOF > $1/etc/php.d/zabbix.ini
[PHP]
post_max_size = 32M
upload_max_filesize = 16M
max_execution_time = 600
max_input_time = 600
[Date]
date.timezone = $(date '+%Z')
EOF

cat <<EOF >> $1/etc/my.cnf
[mysqld]
bind-address = 127.0.0.1
default-character-set=utf8
skip-character-set-client-handshake
EOF
