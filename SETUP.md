### pre-setup

    $ cp -i jeos_profile.sh.example jeos_profile.sh
    $ vi jeos_profile.sh

    $ ./prepare-vmimage.sh

### build vm

    $ sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh build --config-path=./jeos_profile.sh
    $ sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh build --config-path=./jeos_profile.sh

### start vm

    $ sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=openflow  ./jeos-ctl.sh start --config-path=./jeos_profile.sh
    $ sudo VDC_HYPERVISOR=kvm VDC_EDGE_NETWORKING=netfilter ./jeos-ctl.sh start --config-path=./jeos_profile.sh
