#!/bin/bash

set -e

case "${VDC_EDGE_NETWORKING}" in
openvnet) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<'EOS'
  pkg_names="
    openvnet-ruby
    openvnet-common
    openvnet-vnmgr
    openvnet-vna
    openvnet-webapi
  "
  for pkg_name in ${pkg_names}; do
    yumdownloader ${pkg_name}
    rpm --nodeps -ivh `ls ${pkg_name}*`
  done

  cd /opt/axsh/openvnet/vnctl
  PATH=/opt/axsh/openvnet/ruby/bin:${PATH}; bundle install
EOS
