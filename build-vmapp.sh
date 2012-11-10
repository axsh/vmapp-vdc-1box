#!/bin/bash
#
# requires:
#  bash
#  dirname, pwd
#  find, sed
#  vmbuilder.sh => git://github.com/hansode/vmbuilder.git
#
set -e

function list_fakeroot_tree() {
  cd ${fakeroot_dir}
  find . -type f | sed s,^\.,,
}

function generate_copyfile() {
  echo "[INFO] Generating copy.txt"

  [[ -d "${fakeroot_dir}" ]] && {
    while read line; do
      echo ${fakeroot_dir}${line} ${line}
    done < <(list_fakeroot_tree) > ${manifest_dir}/copy.txt
  }

  cat ${manifest_dir}/copy.txt
}

function build_vm() {
  local target=${1:-vmapp-ashiba} arch=${2:-$(arch)}

  echo "[INFO] Building vmimage"

  ${vmbuilder_sh_path} \
   --distro-arch=${arch} \
           --raw=${target}.$(date +%Y%m%d).01.${arch}.raw \
          --copy=${manifest_dir}/copy.txt \
    --execscript=${manifest_dir}/execscript.sh
}

## main

### environment variables

export LC_ALL=C
export LANG=C

### read-only variables

readonly abs_dirname=$(cd $(dirname $0) && pwd)

readonly manifest_dir=${abs_dirname}
readonly fakeroot_dir=${manifest_dir}/fakeroot

readonly vmbuilder_dirpath=${abs_dirname}/..
readonly vmbuilder_sh_path=${vmbuilder_dirpath}/vmbuilder.sh

for arch in x86_64; do
  generate_copyfile
  build_vm vmapp-ashiba ${arch}
done
