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
  local vmimage=$1 arch=$2 hypervisor=$3 multi_suffix=$4
  [[ -n "${vmimage}"      ]] || { echo "[ERROR] invalid argument: 'vmimage_'" >&2; return 1; }
  [[ -n "${arch}"         ]] || { echo "[ERROR] invalid argument: 'arch'" >&2; return 1; }
  [[ -n "${hypervisor}"   ]] || { echo "[ERROR] invalid argument: 'hypervisor'" >&2; return 1; }
  [[ -n "${multi_suffix}" ]] || { echo "[ERROR] invalid argument: 'multi_suffix'" >&2; return 1; }

  local vmimage_base_uri=http://dlc2.wakame.axsh.jp/demo/1box/vmimage
  local vmimage_base_path=${abs_dirname}/guestroot.${hypervisor}.${arch}/var/lib/wakame-vdc/images

  local vmimage_uri=${vmimage_base_uri}/${vmimage}.${arch}.${hypervisor}.${multi_suffix}
  local vmimage_path=${vmimage_base_path}/${vmimage}.${arch}.${hypervisor}.${multi_suffix}

  mkdir -p ${vmimage_base_path}

  echo "===> ${vmimage_path}"
  if ! [[ -f "${vmimage_path}" ]]; then
    curl -fSkLR --retry 3 --retry-delay 3 ${vmimage_uri} -o ${vmimage_path}.tmp
    mv ${vmimage_path}.tmp ${vmimage_path}
  fi
}

function validate_arch() {
  local arch=$1

  case "${arch}" in
  x86_64) ;;
    i686) ;;
       *) return 1 ;;
  esac
}

function validate_hypervisor() {
  local hypervisor=$1

  case "${hypervisor}" in
     kvm) ;;
     lxc) ;;
  openvz) ;;
   dummy) return 1 ;; # no need to download vmimages
       *) return 1 ;; # unknown
  esac
}

function validate_vmimage() {
  local vmimage=$1

  case "${vmimage}" in
       centos-6.6) ;;
          vanilla) ;;
lb-centos6.6-stud) ;;
           lbnode) ;;
                *) return 1 ;; # unknown
  esac
}

function deploy_vmimage_matrix() {
  local hypervisors="${1:-"kvm lxc openvz"}"
  local archs="${2:-"x86_64 i686"}"
 #local vmimages="${3:-"centos-6.6 vanilla lb-centos6.6-stud lbnode"}"
  local vmimages="${3:-"centos-6.6 lb-centos6.6-stud lbnode"}"

  local arch hypervisor vmimage

  for arch in ${archs}; do
    validate_arch ${arch} || continue

    for hypervisor in ${hypervisors}; do
      validate_hypervisor ${hypervisor} || continue

      for vmimage in ${vmimages}; do
        validate_vmimage ${vmimage}

        echo ... ${vmimage} ${arch} ${hypervisor} md.raw.tar.gz
        time deploy_vmimage ${vmimage} ${arch} ${hypervisor} md.raw.tar.gz
      done
    done
  done
}

# $1: hypervisor
# $2: arch
# $3: vmimage

deploy_vmimage_matrix "$@"
