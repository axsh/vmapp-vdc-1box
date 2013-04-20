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
  sed -i "s,hypervisor: .*,hypervisor: 'openvz'," /etc/wakame-vdc/convert_specs/load_balancer.yml

  /opt/axsh/wakame-vdc/rpmbuild/helpers/edit-grub4vz.sh add
  /opt/axsh/wakame-vdc/rpmbuild/helpers/edit-grub4vz.sh enable

  yum install -y http://dlc.wakame.axsh.jp/packages/rhel/6/master/20120912124632gitff83ce0/${basearch}/kmod-openvswitch-vzkernel-1.6.1-1.el6.${distro_arch}.rpm
EOS
