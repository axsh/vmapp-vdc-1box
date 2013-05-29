#!/bin/bash
#
# requires:
#  bash
#  dirname, pwd
#  mkdir, curl, zcat, cp
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

  [[ -d ${vmimage_base_path} ]] || mkdir -p ${vmimage_base_path}

  [[ -f "${vmimage_path}" ]] || {
    curl -fsSkL -o ${vmimage_path} -R ${vmimage_uri}
  }
}

function deploy_vmimage_matrix() {
  local hypervisors="kvm lxc openvz"
  local archs="x86_64 i686"

  for arch in ${archs}; do
    for hypervisor in ${hypervisors}; do
      for vmimage in centos-6.4 vanilla lb-centos6-stud lbnode; do
        echo ... ${vmimage}.${arch} ${hypervisor} md.raw.tar.gz
        time deploy_vmimage ${vmimage}.${arch} ${hypervisor} md.raw.tar.gz
      done
    done
  done
}

deploy_vmimage_matrix
