#!/bin/bash
#
# requires:
#  bash
#  dirname, pwd
#  find, sed
#  vmbuilder.sh => git://github.com/hansode/vmbuilder.git
#
set -e

function vmbuilder_path() {
  # should be added vmbuilder installation path to $PATH environment
  which vmbuilder.sh
}

## variables

### environment variables

export LC_ALL=C
export LANG=C

### read-only variables

readonly abs_dirname=$(cd $(dirname $0) && pwd)

readonly manifest_dir=${abs_dirname}
readonly fakeroot_dir=${manifest_dir}/fakeroot

###

declare vmapp_name=${1:-vmapp-ashiba}

## main

# enable to set PATH at config.env
[[ -f ${abs_dirname}/config.env ]] && . ${abs_dirname}/config.env || :

$(dirname $(vmbuilder_path))/misc/kvm-ctl.sh start --image-path=${raw} \
       --brname=${brname} \
     --mem-size=${mem_size} \
      --cpu-num=${cpu_num} \
     --vnc-port=${vnc_port:-1001} \
 --monitor-port=${monitor_port:-4444} \
  --serial-port=${serial_port:-5555}
