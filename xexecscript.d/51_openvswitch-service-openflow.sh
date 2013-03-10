#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

case "${VDC_EDGE_NETWORKING}" in
openflow) ;;
*) exit 0;;
esac

chroot $1 $SHELL <<EOS
  /opt/axsh/wakame-vdc/rpmbuild/helpers/set-openvswitch-conf.sh
EOS
