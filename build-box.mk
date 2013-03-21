#!/usr/bin/make -f

pre:
	echo quit | nc localhost 4444 || :

lxc: pre
	make $@64.netfilter
	sudo ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh start --vnc-port 1002 --vif-num 2 --mem-size 2048 --cpu-num=4 --brname vboxbr0 --image-path ./1box-$@.netfilter.x86_64.raw
	ssh-keygen -R 10.0.2.15

openvz: pre
	make $@64.netfilter
	sudo ./vmbuilder/kvm/rhel/6/misc/kvm-ctl.sh start --vnc-port 1002 --vif-num 2 --mem-size 2048 --cpu-num=4 --brname vboxbr0 --image-path ./1box-$@.netfilter.x86_64.raw
	ssh-keygen -R 10.0.2.15
