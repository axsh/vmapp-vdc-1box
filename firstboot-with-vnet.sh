#!/bin/bash
#
# requires:
#  bash
#
set -e

# enable dcell configurations in dcmgr.conf
sed -i -e 's/^#\(.*dcell\)/\1/' /etc/wakame-vdc/dcmgr.conf

/var/lib/wakame-vdc/demo/rc.local
/var/lib/openvnet/demo/rc.local

# TODO find the best solution to launch the vnet processes since they are somehow disappear after openvnet/demo/rc.local
initctl start vnet-vnmgr
initctl start vnet-webapi
initctl start vnet-vna

