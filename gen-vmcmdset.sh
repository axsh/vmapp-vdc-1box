#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

vmimage_map='
 centos1d=centos-6.6
 lbnode1d=lbnode
 haproxy1d=lb-centos6*-stud
'

function build_cmdset() {
  local localpath=$1

  [[ -f "${localpath}" ]] || {
    echo file not found :${localpath} >&2
    return 1
  }

  storage_id=${storage_id:-bkst-demo1}
  uuid=${uuid:-centos1d}
  hypervisor=${hypervisor:-openvz}
  arch=${arch:-x86_64}
  localname=$(basename ${localpath})
  storetype=local
  file_format=raw
  container_format=tgz
  root_device=label:root
  service_type=${service_type:-std}
  display_name=${localname}

  checksum=$(md5sum "${localpath}" | cut -d ' ' -f1 )
  alloc_size=$(ls -l "${localpath}" | awk '{print $5}')

  case "${container_format}" in
  "gz")
    echo "get the uncompressed size embedded in the .gz file ${localpath} ..."
    size=$(gzip -l "${localpath}" | awk -v fname="${localpath%.gz}" '$4 == fname {print $2}')
    ;;
  "tgz")
    size=$(tar -ztvf "${localpath}" | awk -v fname="${localname%.tar.gz}" '$6 == fname {print $3}')
    ;;
  "tar")
    size=$(tar -tvf "${localpath}" | awk -v fname="${localname%.tar}" '$6 == fname {print $3}')
    ;;
  *)
    size=${alloc_size}
    ;;
  esac

  cat <<EOS
## ${uuid}

backupobject add \
 --storage-id=${storage_id} \
 --uuid=bo-${uuid} \
 --display-name='${display_name}' \
 --object-key=${localname} \
 --size=${size} \
 --allocation-size=${alloc_size} \
 --checksum=${checksum} \
 --container-format=${container_format} \
 --description='${localname}'
image add local bo-${uuid} \
 --account-id a-shpoolxx \
 --uuid wmi-${uuid} \
 --arch ${arch} \
 --description '${localname} local' \
 --file-format ${file_format} \
 --root-device ${root_device} \
 --service-type ${service_type} \
 --is-public \
 --display-name '${uuid}' \
 --is-cacheable
image features wmi-${uuid} --virtio
EOS
}

function render_cmdset() {
  local hypervisor=$1 arch=$2

  local keyval= uuid= basename= filepath=
  for keyval in ${vmimage_map}; do
    keyval=${keyval}.${arch}

    uuid=${keyval%%=*}
    basename=${keyval##*=}

    case "${arch}" in
      i686) uuid=${uuid}32 ;;
    x86_64) uuid=${uuid}64 ;;
    esac

    filepath=$(find guestroot.${hypervisor}.${arch} -type f -name ${basename}.*)
    [[ -n "${filepath}" ]] || continue

    case ${basename} in
    haproxy1d*) service_type=lb  ;;
    *)          service_type=std ;;
    esac

    echo
    uuid=${uuid} arch=${arch} build_cmdset ${filepath}
  done
}

function generate_cmdset() {
  local hypervisor=$1 arch=$2

  local basepath=guestroot.${hypervisor}.${arch}/var/lib/wakame-vdc/demo/vdc-manage.d
  local filepath=${basepath}/02_core
  mkdir -p ${basepath}

  echo "[INFO] Generating ${filepath}"
  {
    cat <<-EOS
	# vm image (wmi-*)
	# hierarchy: bkst-XXX / bo-XXX / wmi-XXX
	EOS
    render_cmdset ${hypervisor} ${arch}
  } > ${filepath}
}

hhypervisors="${1:-"kvm lxc openvz dummy"}"
archs=${2:-"x86_64 i686"}

for hypervisor in ${hhypervisors}; do
  for arch in ${archs}; do
    generate_cmdset ${hypervisor} ${arch}
  done
done
