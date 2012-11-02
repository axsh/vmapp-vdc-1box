#!/bin/bash
#
# requires:
#  bash
#  dirname, pwd
#  mkdir, rm, rsync, find
#
set -e

## variables

### read-only variables

readonly abs_dirname=$(cd $(dirname $0) && pwd)

### variables for vmbuilder

declare chroot_dir=${1}
declare execscript_part_dir="${abs_dirname}/execscript-part.d"
declare tmpdir=/tmp/$(date +%s)

## main

### %prep

echo "doing execscript.sh: ${chroot_dir}"
[[ -d ${chroot_dir} ]] || {
  echo "no such directory: ${chroot_dir}" >&2
  exit 1
}
[[ -d ${execscript_part_dir} ]] || exit 0

### %setup

mkdir -p ${chroot_dir}/${tmpdir}

### %install

rsync -a ${execscript_part_dir} ${chroot_dir}/${tmpdir}

cat <<EOS | chroot ${chroot_dir} /bin/bash
set -e
find ${tmpdir} ! -type d | sort | while read sub_execscript; do
  [[ -x \${sub_execscript} ]] || continue
  ASHIBA_ENV=${ASHIBA_ENV} \${sub_execscript} || {
    echo "(exitcode=\$?) \${sub_execscript}" >&2
    false
  }
done
EOS

### %clean

rm -rf ${chroot_dir}/${tmpdir}
