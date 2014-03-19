#!/bin/bash

set -e

chroot $1 $SHELL -ex <<'EOS'
  yum install redis
  chkconfig redis on
  sed -i -e 's/^(bind 127.0.0.0)/\#\1/' /etc/redis.conf

  curl -o /etc/yum.repos.d/openvnet.repo -R https://raw.github.com/axsh/openvnet/master/openvnet.repo
  curl -o /etc/yum.repos.d/openvnet-third-party.repo -R https://raw.github.com/axsh/openvnet/master/openvnet-third-party.repo

  yum clean metadata --disablerepo=* --enablerepo=openvnet*
  yum update -y --enablerepo=openvnet*

  yum install -y wakame-vnet
  # yum install -y --skip-broken zeromq3 zeromq3-devel
  # yum install -y openvswitch-1.10.0-1.x86_64
EOS

chroot $1 $SHELL -ex <<EOS
  yum install -y http://download.openvz.org/kernel/branches/rhel6-2.6.32/042stab084.20/vzkernel-2.6.32-042stab084.20.${distro_arch}.rpm
EOS
