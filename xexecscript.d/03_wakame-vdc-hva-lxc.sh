#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

case "${VDC_HYPERVISOR}" in
lxc) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL <<EOS
  yum install -y wakame-vdc-hva-lxc-vmapp-config

  echo "none                    /cgroup                 cgroup  defaults        0 0" >> /etc/fstab
  [[ -d /var/lib/lxc ]] || mkdir /var/lib/lxc
EOS
