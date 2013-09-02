#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<'EOS'
  pkg_names="
   wakame-vdc-webui-vmapp-config
   wakame-vdc-example-1box-webui-vmapp-config
  "

  for pkg_name in ${pkg_names}; do
    yum search  --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6    ${pkg_name} | egrep -q ${pkg_name} || continue
    yum install --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6 -y ${pkg_name}
  done
EOS
