#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<'EOS'
  yum install -y http://dlc.openvnet.axsh.jp/packages/rhel/openvswitch/6.7/openvswitch-2.4.0-1.x86_64.rpm
EOS

chroot $1 $SHELL -ex <<'EOS'
  pkg_names="
   wakame-vdc-natbox-vmapp-config
  "

  for pkg_name in ${pkg_names}; do
    yum search  --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6    ${pkg_name} | egrep -q ${pkg_name} || continue
    yum install --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6 -y ${pkg_name}
  done
EOS
