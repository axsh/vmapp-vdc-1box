vmapp-vdc-1box
==============

[Wakame-vdc](https://github.com/axsh/wakame-vdc) demobox/testbox.

pre-setup
---------

```
$ ./prepare-vmimage.sh
$ make
```

```
$ sudo cp hostroot/etc/sysconfig/network-scripts/ifcfg-vboxbr0 /etc/sysconfig/network-scripts/ifcfg-vboxbr0
$ sudo ifup vboxbr0
```

controlling box
---------------

```
$ ./box-ctl.sh build [hypervisor]
$ ./box-ctl.sh start [hypervisor]
$ ./box-ctl.sh stop  [hypervisor]
```

hypervisor:

+ lxc
+ openvz
+ kvm
+ dummy

custom configuration
--------------------

+ copy.local.txt
+ postcopy.local.txt

+ copy.local.$(arch).txt
+ postcopy.local.$(arch).txt
