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

  yum install -y http://download.openvz.org/kernel/branches/rhel6-2.6.32/042stab084.20/vzkernel-firmware-2.6.32-042stab084.20.noarch.rpm
  yum install -y http://download.openvz.org/kernel/branches/rhel6-2.6.32/042stab084.20/vzkernel-2.6.32-042stab084.20.x86_64.rpm

  sed -i -e 's/^default=[0-9]*/default=1/' /boot/grub/grub.conf

  cat <<GCNF >> /boot/grub/grub.conf
  title OpenVZ (2.6.32-042stab084.20)
          root (hd0,0)
          kernel /boot/vmlinuz-2.6.32-042stab084.20 ro root=LABEL=root rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel=auto  KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM
          initrd /boot/initramfs-2.6.32-042stab084.20.img
  GCNF

  curl -o /etc/yum.repos.d/openvnet.repo -R https://raw.github.com/axsh/openvnet/master/openvnet.repo
  curl -o /etc/yum.repos.d/openvnet-third-party.repo -R https://raw.github.com/axsh/openvnet/master/openvnet-third-party.repo

  yum clean metadata --disablerepo=* --enablerepo=openvnet*

  curl -O http://dlc.openvnet.axsh.jp/packages/rhel/6/third_party/current/x86_64/openvswitch-1.10.0-1.x86_64.rpm
  rpm --force --nodeps -ivh openvswitch-1.10.0-1.x86_64.rpm

  yumdownloader wakame-vnet-ruby
  yumdownloader wakame-vnet-common
  yumdownloader wakame-vnet-vnmgr
  yumdownloader wakame-vnet-vna
  yumdownloader wakame-vnet-webapi

  rpm -ivh wakame-vnet-ruby-2.0.0.247.axsh0-1.x86_64.rpm
  rpm --nodeps -ivh `ls wakame-vnet-common*`
  rpm --nodeps -ivh `ls wakame-vnet-vnmgr*`
  rpm --nodeps -ivh `ls wakame-vnet-vna*`
  rpm --nodeps -ivh `ls wakame-vnet-webapi*`
EOS
