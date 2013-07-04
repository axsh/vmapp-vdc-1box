#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL <<'EOS'
  pkg_names="
   wakame-vdc-sta-vmapp-config
   wakame-vdc-example-1box-sta-vmapp-config
  "

  for pkg_name in ${pkg_names}; do
    yum search ${pkg_name} | egrep -q ${pkg_name} || continue
    yum install -y ${pkg_name}
  done

  chkconfig --list tgtd
  chkconfig        tgtd on
  chkconfig --list tgtd
EOS
