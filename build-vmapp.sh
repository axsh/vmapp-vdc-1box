#!/bin/bash
#
# requires:
#  bash
#  dirname, pwd
#  find, sed
#  vmbuilder.sh => git://github.com/hansode/vmbuilder.git
#
set -e

function list_guestroot_tree() {
  cd ${guestroot_dir}
  find . ! -type d | sed s,^\.,, | egrep -v ^/.gitkeep
}

function generate_copyfile() {
  echo "[INFO] Generating copy.txt"

  [[ -d "${guestroot_dir}" ]] && {
    while read line; do
      echo ${guestroot_dir}${line} ${line}
    done < <(list_guestroot_tree) > ${manifest_dir}/copy.txt
  }

  cat ${manifest_dir}/copy.txt
}

function vmbuilder_path() {
  # should be added vmbuilder installation path to $PATH environment
  which vmbuilder.sh
}

function build_vm() {
  local target=${1:-vmapp-ashiba} arch=${2:-$(arch)}

  echo "[INFO] Building vmimage"

  $(vmbuilder_path) \
   --distro-arch=${arch} \
           --raw=${raw:-${target}.$(date +%Y%m%d).01.${arch}.raw} \
          --copy=${manifest_dir}/copy.txt \
    --execscript=${manifest_dir}/execscript.sh
}

## variables

### environment variables

export LC_ALL=C
export LANG=C

### read-only variables

readonly abs_dirname=$(cd $(dirname $0) && pwd)

readonly manifest_dir=${abs_dirname}
readonly guestroot_dir=${manifest_dir}/guestroot

###

declare vmapp_name=${1:-vmapp-ashiba}

## main

# enable to set PATH at config.env
[[ -f ${abs_dirname}/config.env ]] && . ${abs_dirname}/config.env || :

generate_copyfile
build_vm ${vmapp_name}
