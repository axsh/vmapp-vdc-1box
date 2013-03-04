#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

chroot $1 $SHELL <<'EOS'
declare arch=$(arch)
declare basearch=

case ${arch} in
x86_64) basearch=x86_64 ;;
  i*86) basearch=i386   ;;
esac

rpm -ql kmod-openvswitch-vzkernel >/dev/null || yum install -y http://dlc.wakame.axsh.jp/packages/rhel/6/master/20120912124632gitff83ce0/${basearch}/kmod-openvswitch-vzkernel-1.6.1-1.el6.${arch}.rpm
EOS
