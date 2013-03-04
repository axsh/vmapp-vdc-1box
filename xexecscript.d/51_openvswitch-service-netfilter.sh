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

chroot $1 $SHELL <<EOS
  # default
  yum remove -y kmod-openvswitch-vzkernel
  chkconfig openvswitch off
  cp -f /etc/rc.d/rc.local.netfilter /etc/rc.d/rc.local
EOS
