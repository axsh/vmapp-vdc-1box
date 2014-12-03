#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

# https://access.redhat.com/site/documentation/ja-JP/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/sec-Using_Yum_Variables.html

if [[ -n "${distro_ver}" ]]; then
  mkdir -p             ${chroot_dir}/etc/yum/vars

  echo ${distro_ver} > ${chroot_dir}/etc/yum/vars/releasever
  cat                  ${chroot_dir}/etc/yum/vars/releasever
fi
