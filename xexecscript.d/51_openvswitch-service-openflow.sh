#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

chroot $1 $SHELL <<EOS
case "${ASHIBA_ENV}" in
openflow)
  /opt/axsh/wakame-vdc/rpmbuild/helpers/set-openvswitch-conf.sh
  cp -f /etc/rc.d/rc.local.openflow /etc/rc.d/rc.local
  ;;
esac

EOS
