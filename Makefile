SHELL=/bin/bash

all:
	git submodule update --init --recursive

# lxc

matrix: lxc kvm openvz

lxc: lxc64 lxc32

lxc64: lxc64.netfilter lxc64.openflow
lxc64.netfilter:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=netfilter setarch x86_64 ./jeos-ctl.sh build --config-path=./config.env.vmapp
lxc64.openflow:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=openflow  setarch x86_64 ./jeos-ctl.sh build --config-path=./config.env.vmapp

lxc32: lxc32.netfilter lxc32.openflow
lxc32.netfilter:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=netfilter setarch i686   ./jeos-ctl.sh build --config-path=./config.env.vmapp
lxc32.openflow:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=openflow  setarch i686   ./jeos-ctl.sh build --config-path=./config.env.vmapp

# kvm

kvm: kvm64 kvm32

kvm64: kvm64.netfilter kvm64.openflow
kvm64.netfilter:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=netfilter setarch x86_64 ./jeos-ctl.sh build --config-path=./config.env.vmapp
kvm64.openflow:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=openflow  setarch x86_64 ./jeos-ctl.sh build --config-path=./config.env.vmapp

kvm32: kvm32.netfilter kvm32.openflow
kvm32.netfilter:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=netfilter setarch i686   ./jeos-ctl.sh build --config-path=./config.env.vmapp
kvm32.openflow:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=openflow  setarch i686   ./jeos-ctl.sh build --config-path=./config.env.vmapp

# openvz

openvz: openvz64 openvz32

openvz64: openvz64.netfilter openvz64openflow
openvz64.netfilter:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=netfilter setarch x86_64 ./jeos-ctl.sh build --config-path=./config.env.vmapp
openvz64openflow:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=openflow  setarch x86_64 ./jeos-ctl.sh build --config-path=./config.env.vmapp

openvz32: openvz32.netfilter openvz32.openflow
openvz32.netfilter:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=netfilter setarch i686   ./jeos-ctl.sh build --config-path=./config.env.vmapp
openvz32.openflow:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=openflow  setarch i686   ./jeos-ctl.sh build --config-path=./config.env.vmapp
