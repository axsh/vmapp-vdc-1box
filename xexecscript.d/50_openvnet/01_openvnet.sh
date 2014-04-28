#!/bin/bash

set -e

case "${VDC_EDGE_NETWORKING}" in
openvnet) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<'EOS'
  yum install -y redis yum-utils libpcap-devel
  chkconfig redis on
  sed -i -e 's/^\(bind\)/#\1/' /etc/redis.conf

  curl -o /etc/yum.repos.d/openvnet.repo -R https://raw.githubusercontent.com/axsh/openvnet/master/openvnet.repo
  curl -o /etc/yum.repos.d/openvnet-third-party.repo -R https://raw.githubusercontent.com/axsh/openvnet/master/openvnet-third-party.repo

  yum clean metadata --disablerepo=* --enablerepo=openvnet*

  curl -O http://dlc.openvnet.axsh.jp/packages/rhel/6/third_party/current/x86_64/openvswitch-1.10.0-1.x86_64.rpm
  rpm --force --nodeps -ivh openvswitch-1.10.0-1.x86_64.rpm
EOS
