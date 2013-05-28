#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

case "${VDC_HYPERVISOR}" in
dummy) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL <<EOS
  yum install -y wakame-vdc-hva-common-vmapp-config
  sed -i "s,hypervisor: .*,hypervisor: 'dummy'," /etc/wakame-vdc/convert_specs/load_balancer.yml
EOS
