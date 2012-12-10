ashiba-skel
===========

skeleton to build environments using vmbuilder's execscript/copy.

System Requirements
-------------------

+ [vmbuilder.sh](https://github.com/hansode/vmbuilder/tree/master/kvm/rhel/6)

Installing ashiba-skel
----------------------

    $ git clone git://github.com/hansode/ashiba-skel.git

vmbuilder.sh pre-setup
----------------------

    $ cd ashiba-skel
    $ git submodule update
    $ git submodule init

Configuring jeos params
-----------------------

    $ cp -i jeos_profile.sh.example jeos_profile.sh
    $ vi jeos_profile.sh

Building virtual machine image with ashiba
------------------------------------------

    $ sudo ./jeos-ctl.sh build --config-path=./jeos_profile.sh
