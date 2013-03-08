SHELL=/bin/bash

all:
	git submodule update --init --recursive

matrix: lxc kvm openvz

lxc: lxc64 lxc32
lxc64:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh build --config-path=./config.env.vmapp
lxc32:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh build --config-path=./config.env.vmapp

kvm: kvm64 kvm32
kvm64:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh build --config-path=./config.env.vmapp
kvm32:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh build --config-path=./config.env.vmapp

openvz: openvz64 openvz32
openvz64:
	time. sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh build --config-path=./config.env.vmapp
openvz32:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh build --config-path=./config.env.vmapp
