#!/bin/bash
#
# requires:
#  bash
#  dirname, pwd
#  curl, zcat, cp
#
set -e
set -x

readonly abs_dirname=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
declare vmimage_base_path=${abs_dirname}/guestroot/var/lib/wakame-vdc/images
declare vmimage_base_uri=http://dlc.wakame.axsh.jp.s3.amazonaws.com/demo/vmimage

function deploy_vmimage() {
  local vmimage_basename=$1
  [[ -n "${vmimage_basename}" ]] || { echo "[ERROR] invalid argument: 'vmimage_basename'" >&2; return 1; }

  local vmimage_uri=${vmimage_base_uri}/${vmimage_basename}.gz
  local vmimage_path=${vmimage_base_path}/${vmimage_basename}

  [[ -f "${vmimage_path}" ]] || {
    curl -L -o ${vmimage_path}.gz -R ${vmimage_uri}
    zcat ${vmimage_path}.gz | cp --sparse=always /dev/stdin ${vmimage_path}
  }
}

deploy_vmimage ubuntu-lucid-kvm-md-32.raw
deploy_vmimage lb-centos-openvz-md-64-stud.raw
