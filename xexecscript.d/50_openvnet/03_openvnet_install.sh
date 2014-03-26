#!/bin/bash

set -e

case "${VDC_EDGE_NETWORKING}" in
openvnet) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<'EOS'
  pkg_names="
    wakame-vnet-ruby
    wakame-vnet-common
    wakame-vnet-vnmgr
    wakame-vnet-vna
  "
  for pkg_name in ${pkg_names}; do
    yumdownloader ${pkg_name}
    rpm --nodeps -ivh `ls ${pkg_name}*`
  done
EOS

#  yumdownloader wakame-vnet-common
#  yumdownloader wakame-vnet-vnmgr
#  yumdownloader wakame-vnet-vna
#  yumdownloader wakame-vnet-webapi
#
#  rpm -ivh wakame-vnet-ruby-2.0.0.247.axsh0-1.x86_64.rpm
#  rpm --nodeps -ivh `ls wakame-vnet-common*`
#  rpm --nodeps -ivh `ls wakame-vnet-vnmgr*`
#  rpm --nodeps -ivh `ls wakame-vnet-vna*`
#  rpm --nodeps -ivh `ls wakame-vnet-webapi*`
