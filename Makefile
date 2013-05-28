SHELL=/bin/bash

all:
	git submodule update --init --recursive
	git submodule foreach git pull origin master

matrix: lxc kvm openvz

# lxc

lxc: lxc64 lxc32

lxc64: lxc64.netfilter lxc64.openflow
lxc64.netfilter:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=netfilter setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
lxc64.openflow:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=openflow  setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf

lxc32: lxc32.netfilter lxc32.openflow
lxc32.netfilter:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=netfilter setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
lxc32.openflow:
	time sudo VDC_HYPERVISOR=lxc VDC_EDGE_NETWORKING=openflow  setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf

# kvm

kvm: kvm64 kvm32

kvm64: kvm64.netfilter kvm64.openflow
kvm64.netfilter:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=netfilter setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
kvm64.openflow:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=openflow  setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf

kvm32: kvm32.netfilter kvm32.openflow
kvm32.netfilter:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=netfilter setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
kvm32.openflow:
	time sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=openflow  setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf

# openvz

openvz: openvz64 openvz32

openvz64: openvz64.netfilter openvz64.openflow
openvz64.netfilter:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=netfilter setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
openvz64.openflow:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=openflow  setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf

openvz32: openvz32.netfilter openvz32.openflow
openvz32.netfilter:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=netfilter setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
openvz32.openflow:
	time sudo VDC_HYPERVISOR=openvz VDC_EDGE_NETWORKING=openflow  setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf

# dummy

dummy: dummy64 dummy32

dummy64: dummy64.netfilter dummy64.openflow
dummy64.netfilter:
	time sudo VDC_HYPERVISOR=dummy VDC_EDGE_NETWORKING=netfilter setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
dummy64.openflow:
	time sudo VDC_HYPERVISOR=dummy VDC_EDGE_NETWORKING=openflow  setarch x86_64 ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf

dummy32: dummy32.netfilter dummy32.openflow
dummy32.netfilter:
	time sudo VDC_HYPERVISOR=dummy VDC_EDGE_NETWORKING=netfilter setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
dummy32.openflow:
	time sudo VDC_HYPERVISOR=dummy VDC_EDGE_NETWORKING=openflow  setarch i686   ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh build --config-path=./vmbuilder.conf
