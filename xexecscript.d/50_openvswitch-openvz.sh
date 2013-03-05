#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

case "${VDC_HYPERVISOR}" in
openvz) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL <<EOS
  yum install -y http://dlc.wakame.axsh.jp/packages/rhel/6/master/20120912124632gitff83ce0/${basearch}/kmod-openvswitch-vzkernel-1.6.1-1.el6.${distro_arch}.rpm
EOS
