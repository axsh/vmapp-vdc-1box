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
  build|start|stop|raw2vdi|raw2vmdk|dist_raw|dist_vdi|dist_vmdk|release_raw|release_vdi|release_vmdk)
    ;;
  *)
    echo "[ERROR] unknown cmd: ${cmd} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2
    return 1
  esac
}

function valid_hypervisor?() {
  local hypervisor=$1

  case "${hypervisor}" in
  lxc|openvz|kvm|dummy)
    ;;
  *)
   echo "[ERROR] unknown hypervisor: ${hypervisor} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2
   return 1
   ;;
  esac
}

### box

function release_id() {
  cat VDC-VERSION.txt
}

function base_image_file() {
  echo ./1box-${hypervisor}.${VDC_EDGE_NETWORKING}.$(arch)
}

function build_box() {
  local arch_type
  case "$(arch)" in
    i686) arch_type=32 ;;
  x86_64) arch_type=64 ;;
  esac

  make ${hypervisor}${arch_type}.${VDC_EDGE_NETWORKING}
  sudo $SHELL -c "chown -R \${SUDO_UID}:\${SUDO_GID} 1box-${hypervisor}.${VDC_EDGE_NETWORKING}.$(arch).raw"
}

function start_box() {
  sudo ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh start \
   --vnc-port     ${vnc_port} \
   --vif-num      ${vif_num}  \
   --mem-size     ${mem_size} \
   --cpu-num      ${cpu_num}  \
   --cpu-type     ${cpu_type} \
   --brname       ${brname}   \
   --monitor-port ${monitor_port} \
   --serial-port  ${serial_port}  \
   --drive-type   ${drive_type} \
   --nic-driver   ${nic_driver} \
   --rtc          ${rtc} \
   --image-path   $(base_image_file).raw
}

function stop_box() {
  echo quit | nc localhost ${monitor_port}
}

function release_base_box() {
  local format=$1

  build_box
  raw2${format}_box
  dist_${format}_box
}

function release_raw_box() {
  release_base_box raw
}

function release_vdi_box() {
  release_base_box vdi
}

function release_vmdk_box() {
  release_base_box vmdk
}

function dist_raw_box() {
  time tar zScvpf $(base_image_file).raw.$(release_id).tar.gz $(base_image_file).raw
}

function dist_vdi_box() {
  local format=vdi
  time zip $(base_image_file).${format}.$(release_id).zip $(base_image_file).${format}
}

function dist_vmdk_box() {
  local format=vmdk
  time zip $(base_image_file).${format}.$(release_id).zip $(base_image_file).${format}
}

function raw2raw_box() {
  :
}

function raw2vdi_box() {
  local format=vdi
  [[ -f "$(base_image_file).${format}" ]] && rm -f $(base_image_file).${format}
  time ./vmbuilder/kvm/rhel/6/misc/raw2${format}.sh $(base_image_file).raw
}

function raw2vmdk_box() {
  local format=vmdk
  [[ -f "$(base_image_file).${format}" ]] && rm -f $(base_image_file).${format}
  time ./vmbuilder/kvm/rhel/6/misc/raw2${format}.sh $(base_image_file).raw
}

## variables

### kvm-ctl.sh

[[ -f ${BASH_SOURCE[0]%/*}/vmbuilder.conf ]] && . ${BASH_SOURCE[0]%/*}/vmbuilder.conf

monitor_port=${monitor_port:-4444}
vnc_port=${vnc_port:-1002}
serial_port=${serial_port:-5555}
vif_num=${vif_num:-1}
mem_size=${mem_size:-2048}
cpu_num=${cpu_num:-4}
cpu_type=${cpu_type:-host}
brname=${brname:-vboxbr0}
drive_type=${drive_type:-virtio} # [ virtio, ide ]
nic_driver=${nic_driver:-virtio-net-pci} # [ virtio-net-pci, e1000 ]
rtc=${rtc:-base=localtime}

### this script

declare cmd=${1:?"[ERROR] invalid parameter (${BASH_SOURCE[0]##*/}:${LINENO})"}
declare hypervisor=${2:?"[ERROR] invalid parameter (${BASH_SOURCE[0]##*/}:${LINENO})"}

VDC_EDGE_NETWORKING=${VDC_EDGE_NETWORKING:-netfilter}

## validate

valid_hypervisor? ${hypervisor} || exit 1
valid_cmd? ${cmd} || exit 1

## main

${cmd}_box ${hypervisor}
