# -*-Shell-script-*-
#
# requires:
#  bash
#

# vmbuilder

## prepare

name=vdcbox

## disk layout

#raw=$(pwd)/${name}.raw
#rootsize=$((1024 * 8))
#bootsize=0
#swapsize=0

## network configuration

hostname=wakame-vdc

### /opt/axsh/wakame-vdc/rpmbuild/helpers/setup-bridge-if.sh (nic configuration script) requires shell variable or environment variable.
export gw=10.0.2.2
export ip=10.0.2.15
export mask=255.255.255.0

#nictab=$(pwd)/${name}.nictab # nic layout

## account

#rootpass=root

## post install

execscript=$(pwd)/execscript.sh
copy=$(pwd)/copy.txt

# kvm-ctl

brname=vboxbr0
image_path=${raw}
#cpu_num=1

#viftab=$(pwd)/${name}.viftab # vif layout

    vnc_port=$((1001 + ${node_id:-1}))
monitor_port=$((4444 + ${node_id:-1}))
 serial_port=$((5555 + ${node_id:-1}))

# mix jeos
[[ -f $(pwd)/jeosrc.sh ]] && . $(pwd)/jeosrc.sh || :
