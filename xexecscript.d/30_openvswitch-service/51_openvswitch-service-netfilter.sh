#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

case "${VDC_EDGE_NETWORKING}" in
netfilter) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<EOS
  chkconfig --list openvswitch && { chkconfig openvswitch off; } || :
EOS

case "${VDC_HYPERVISOR}" in
openvz) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<EOS
  # default
  yum remove -y kmod-openvswitch-vzkernel
EOS
