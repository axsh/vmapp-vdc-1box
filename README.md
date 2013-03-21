vmapp-vdc-1box
==============

### pre-setup

    $ cp -i vmbuilder.conf.example vmbuilder.conf
    $ ./prepare-vmimage.sh
    $ make

### build & run

    $ ./build-box.mk lxc
    $ ./build-box.mk openvz
