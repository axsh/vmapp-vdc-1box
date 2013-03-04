#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

case "${VDC_HYPERVISOR}" in
openvz) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL <<EOS
  yum install -y wakame-vdc-hva-openvz-vmapp-config

  /opt/axsh/wakame-vdc/rpmbuild/helpers/edit-grub4vz.sh add
  /opt/axsh/wakame-vdc/rpmbuild/helpers/edit-grub4vz.sh enable
EOS
