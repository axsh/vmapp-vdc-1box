SHELL=/bin/bash

all:
	git submodule update --init --recursive

matrix: lxc kvm openvz

lxc:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh build --config-path=./config.env.vmapp
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh build --config-path=./config.env.vmapp

kvm:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh build --config-path=./config.env.vmapp
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh build --config-path=./config.env.vmapp

openvz:
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh build --config-path=./config.env.vmapp
	time sudo VDC_HYPERVISOR=$@ VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh build --config-path=./config.env.vmapp
