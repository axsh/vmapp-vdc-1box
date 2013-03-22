vmapp-vdc-1box
==============

[Wakame-VDC](https://github.com/axsh/wakame-vdc) demobox/testbox.

pre-setup
---------

```
$ cp -i vmbuilder.conf.example vmbuilder.conf
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
