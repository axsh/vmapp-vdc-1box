#!/bin/bash
#
# description:
#  Controll vm
#
# requires:
#  bash
#  dirname, pwd
#  sed, head
#  kvm-ctl.sh
#
# import:
#  utils: extract_args, shlog
#
# usage:
#
#  $0 build   --config-path=/path/to/jeos.conf
#  $0 start   --config-path=/path/to/jeos.conf
#  $0 stop    --config-path=/path/to/jeos.conf
#  $0 console --config-path=/path/to/jeos.conf
#  $0 info    --config-path=/path/to/jeos.conf
#  $0 dump    --config-path=/path/to/jeos.conf
#  $0 list
#
set -e

## private functions

function register_options() {
  debug=${debug:-}
  [[ -z "${debug}" ]] || set -x

  config_path=${config_path:-}
}

function validate_options() {
  [[ -f "${config_path}" ]] || { echo "[ERROR] Invalid option '--config-path=${config_path}'. file not found. (jeos-ctl.sh:${LINENO})" >&2; return 1; }
}

function controll_vm() {
  local cmd=$1
  [[ -n "${cmd}" ]] || { echo "[ERROR] Invalid argument: cmd:${cmd} (jeos-ctl.sh:${LINENO})" >&2; return 1; }

  case "${cmd}" in
  build)
    time ${abs_dirname}/vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh ${cmd} --config-path=${config_path}
    ;;
  start|stop|console|info|dump)
    ${abs_dirname}/vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh ${cmd} --config-path=${config_path}
    ;;
  list)
    ${abs_dirname}/vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh ${cmd}
    ;;
  *)
    echo $"USAGE: $0 [start] OPTIONS..." >&2
    return 2
  ;;
  esac
}

### read-only variables

readonly abs_dirname=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

### include files

. ${abs_dirname}/vmbuilder/kvm/rhel/6/functions/utils.sh

### prepare

extract_args $*

### main

declare cmd="$(echo ${CMD_ARGS} | sed "s, ,\n,g" | head -1)"

register_options
validate_options
load_config ${config_path}
controll_vm ${cmd}
