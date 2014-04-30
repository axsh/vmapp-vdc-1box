#!/bin/bash

set -e

case "${VDC_HYPERVISOR}" in
openvz) ;;
*) exit 0 ;;
esac


chroot $1 $SHELL -ex <<'EOS'
  vzkernel_version=2.6.32-042stab084.20

  yum install -y http://download.openvz.org/kernel/branches/rhel6-2.6.32/042stab084.20/vzkernel-firmware-${vzkernel_version}.noarch.rpm
  yum install -y http://download.openvz.org/kernel/branches/rhel6-2.6.32/042stab084.20/vzkernel-${vzkernel_version}.x86_64.rpm

  [[ -z `grep ${vzkernel_version} /mnt/boot/grub/grub.conf` ]] && {
    cat <<'GCNF' >> /boot/grub/grub.conf
title OpenVZ (2.6.32-042stab084.20)
        root (hd0,0)
        kernel /boot/vmlinuz-2.6.32-042stab084.20 ro root=LABEL=root rd_NO_LUKS rd_NO_LVM LANG=en_US.UTF-8 rd_NO_MD SYSFONT=latarcyrheb-sun16 crashkernel=auto  KEYBOARDTYPE=pc KEYTABLE=us rd_NO_DM
        initrd /boot/initramfs-2.6.32-042stab084.20.img
GCNF
  }

  IFS=$'\n'
  kernel_list=(`grep "title" /boot/grub/grub.conf`)

  for i in `seq 0 $((${#kernel_list[*]}-1))`; do
    if [[ "${kernel_list[${i}]}" =~ "${vzkernel_version}" ]]; then
      sed -i -e "s/^default=[0-9]*/default=${i}/" /boot/grub/grub.conf
    fi
  done

EOS
