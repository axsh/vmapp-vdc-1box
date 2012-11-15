### pre-setup

    $ ./prepare-vmimage.sh

    $ ln -s config.env.local.example config.env.local
    $ ln -s config.env.vmapp.example config.env.vmapp

### build vm

    $ time sudo ASHIBA_ENV=openflow  ./build-vmapp.sh
    $ time sudo ASHIBA_ENV=netfilter ./build-vmapp.sh

### start vm

    $ time sudo ASHIBA_ENV=openflow  ./start-vmapp.sh
    $ time sudo ASHIBA_ENV=netfilter ./start-vmapp.sh
