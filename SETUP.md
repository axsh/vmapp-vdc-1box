### pre-setup

    $ ./prepare-vmimage.sh
    $ ln -s jeos_profile.sh config.env.vmapp

### build vm

    $ sudo ASHIBA_ENV=openflow  ./jeos-ctl.sh build --config-path=./config.env.vmapp
    $ sudo ASHIBA_ENV=netfilter ./jeos-ctl.sh build --config-path=./config.env.vmapp

### start vm

    $ sudo ASHIBA_ENV=openflow  ./jeos-ctl.sh start --config-path=./config.env.vmapp
    $ sudo ASHIBA_ENV=netfilter ./jeos-ctl.sh start --config-path=./config.env.vmapp
