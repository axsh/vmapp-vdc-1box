#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

if [[ -f VDC-VERSION.txt ]]; then
  rm -f VDC-VERSION.txt
fi

chroot $1 $SHELL -ex <<'EOS' > VDC-VERSION.txt
  rpm -qa --qf '%{Release}\n' wakame-vdc | cut -d . -f 1
EOS

bash -c 'chown -R ${SUDO_UID}:${SUDO_GID} VDC-VERSION.txt'
