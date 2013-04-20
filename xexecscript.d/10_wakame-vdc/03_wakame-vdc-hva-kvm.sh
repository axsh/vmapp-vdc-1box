#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

case "${VDC_HYPERVISOR}" in
kvm) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL <<EOS
  yum install -y wakame-vdc-hva-kvm-vmapp-config
  sed -i "s,hypervisor: .*,hypervisor: 'kvm'," /etc/wakame-vdc/convert_specs/load_balancer.yml
EOS
