#!/bin/bash
#
# requires:
#  bash
#
set -e

## functions

### validation

function valid_cmd?() {
  local cmd=$1

  case "${cmd}" in
  build|start|stop)
    ;;
  *)
    echo "[ERROR] unknown cmd: ${cmd} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2
    return 1
  esac
}

function valid_hypervisor?() {
  local hypervisor=$1

  case "${hypervisor}" in
  lxc|openvz|kvm)
    ;;
  *)
   echo "[ERROR] unknown hypervisor: ${hypervisor} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2
   return 1
   ;;
  esac
}

### box

function build_box() {
  local hypervisor=$1
  [[ -n "${hypervisor}" ]] || { echo "[ERROR] invalid parameter (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  valid_hypervisor? ${hypervisor} || return 1

  local arch_type
  case "$(arch)" in
    i686) arch_type=32 ;;
  x86_64) arch_type=64 ;;
  esac

  make ${hypervisor}${arch_type}.${VDC_EDGE_NETWORKING:-netfilter}
}

function start_box() {
  local hypervisor=$1
  [[ -n "${hypervisor}" ]] || { echo "[ERROR] invalid parameter (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  valid_hypervisor? ${hypervisor} || return 1

  sudo ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh start \
   --vnc-port 1002 \
   --vif-num  2 \
   --mem-size 2048 \
   --cpu-num  4 \
   --brname vboxbr0 \
   --image-path ./1box-${hypervisor}.netfilter.$(arch).raw
}

function stop_box() {
  local hypervisor=$1
  [[ -n "${hypervisor}" ]] || { echo "[ERROR] invalid parameter (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  valid_hypervisor? ${hypervisor} || return 1

  echo quit | nc localhost 4444
}

## variables

declare cmd=${1:?"[ERROR] invalid parameter (${BASH_SOURCE[0]##*/}:${LINENO})"}
declare hypervisor=${2:?"[ERROR] invalid parameter (${BASH_SOURCE[0]##*/}:${LINENO})"}

## validate

valid_hypervisor? ${hypervisor} || exit 1
valid_cmd? ${cmd} || exit 1

## main

${cmd}_box ${hypervisor}
