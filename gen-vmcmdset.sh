#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail

vmimage_map='
 centos1d64=centos-6.4.x86_64
 lbnode1d64=lbnode.x86_64
 haproxy1d64=lb-centos6*-stud.x86_64
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
  local hypervisor=$1

  local keyval= uuid= basename= filepath= arch=
  for keyval in ${vmimage_map}; do
    uuid=${keyval%%=*}
    basename=${keyval##*=}

    filepath=$(find guestroot.${hypervisor}* -type f -name ${basename}.*)

    case ${basename} in
    *.i686)   arch=x86    ;;
    *.x86_64) arch=x86_64 ;;
    esac

    case ${basename} in
    haproxy1d*) service_type=lb  ;;
    *)          service_type=std ;;
    esac

    echo
    uuid=${uuid} arch=${arch} build_cmdset ${filepath}
  done
}

function generate_cmdset() {
  local hypervisor=$1

  local basepath=guestroot.${hypervisor}/var/lib/wakame-vdc/demo/vdc-manage.d
  local filepath=${basepath}/02_core
  mkdir -p ${basepath}

  echo "[INFO] Generating ${filepath}"
  {
    cat <<-EOS
	# vm image (wmi-*)
	# hierarchy: bkst-XXX / bo-XXX / wmi-XXX
	EOS
    render_cmdset ${hypervisor}
  } > ${filepath}
}

for hypervisor in kvm lxc openvz dummy; do
  generate_cmdset ${hypervisor}
done
