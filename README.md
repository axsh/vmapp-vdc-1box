vmapp-vdc-1box
==============

### pre-setup

    $ cp -i jeos_profile.sh.example jeos_profile.sh
    $ ./prepare-vmimage.sh
    $ make

### build & run

    $ ./build-box.mk lxc
    $ ./build-box.mk openvz
