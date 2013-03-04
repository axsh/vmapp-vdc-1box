#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

case "${ASHIBA_ENV}" in
openflow) ;;
*) exit 0;;
esac

chroot $1 $SHELL <<EOS
  /opt/axsh/wakame-vdc/rpmbuild/helpers/set-openvswitch-conf.sh
  cp -f /etc/rc.d/rc.local.openflow /etc/rc.d/rc.local
EOS
