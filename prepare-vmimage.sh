#!/bin/bash
#
# requires:
#  bash
#  dirname, pwd
#  curl, zcat, cp
#
set -e
#set -x

readonly abs_dirname=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

function deploy_vmimage() {
  local vmimage_basename=$1 hypervisor=$2 multi_suffix=$3
  [[ -n "${vmimage_basename}" ]] || { echo "[ERROR] invalid argument: 'vmimage_basename'" >&2; return 1; }
  [[ -n "${hypervisor}"       ]] || { echo "[ERROR] invalid argument: 'hypervisor'" >&2; return 1; }
  [[ -n "${multi_suffix}"     ]] || { echo "[ERROR] invalid argument: 'multi_suffix'" >&2; return 1; }

  local vmimage_base_uri=http://dlc.wakame.axsh.jp.s3.amazonaws.com/demo/1box/vmimage
  local vmimage_base_path=${abs_dirname}/guestroot.${hypervisor}/var/lib/wakame-vdc/images

  local vmimage_uri=${vmimage_base_uri}/${vmimage_basename}.${hypervisor}.${multi_suffix}
  local vmimage_path=${vmimage_base_path}/${vmimage_basename}.${hypervisor}.${multi_suffix}

  [[ -f "${vmimage_path}" ]] || {
    curl -fsSkL -o ${vmimage_path} -R ${vmimage_uri}
  }
}

for arch in x86_64 i686; do

for hypervisor in kvm lxc openvz; do
  for vmimage in centos-6.3 vanilla; do
    echo ... ${vmimage}.${arch} ${hypervisor} md.raw.tar.gz
    deploy_vmimage ${vmimage}.${arch} ${hypervisor} md.raw.tar.gz
  done
done

done
