#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

chroot $1 $SHELL <<EOS
case "${ASHIBA_ENV}" in
netfilter)
  # default
  yum remove -y kmod-openvswitch-vzkernel
  chkconfig openvswitch off
  cp -f /etc/rc.d/rc.local.netfilter /etc/rc.d/rc.local
  ;;
esac

EOS
