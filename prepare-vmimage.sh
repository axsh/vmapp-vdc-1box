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
readonly vmimage_basename=ubuntu-lucid-kvm-md-32.raw
readonly vmimage_path=${abs_dirname}/fakeroot/var/lib/wakame-vdc/images/${vmimage_basename}
readonly vmimage_uri=http://dlc.wakame.axsh.jp.s3.amazonaws.com/demo/vmimage/ubuntu-lucid-kvm-md-32.raw.gz

function deploy_vmimage() {
  [[ -f "${vmimage_path}" ]] || {
    curl -o ${vmimage_path}.gz -R ${vmimage_uri}
    zcat ${vmimage_path}.gz | cp --sparse=always /dev/stdin ${vmimage_path}
  }
}

deploy_vmimage
