#!/bin/bash
#
# requires:
#  bash
#
# usage:
#  $ gen-image-size-params.sh [file.raw.tar.gz]
#

function build_cmdset() {
  local localpath=$1

  [[ -f "${localpath}" ]] || {
    echo file not found :${localpath} >&2
    return 1
  }

  local localname=$(basename ${localpath})
  local container_format=tgz

  local checksum=$(md5sum "${localpath}" | cut -d ' ' -f1 )
  local alloc_size=$(ls -l "${localpath}" | awk '{print $5}')
  local size

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

  cat <<-EOS
	size=${size}
	allocation-size=${alloc_size}
	checksum=${checksum}
	EOS
}

while [[ "${1}" ]]; do
  build_cmdset ${1}
  shift
done
