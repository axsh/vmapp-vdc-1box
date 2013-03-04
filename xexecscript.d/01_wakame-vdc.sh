#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL <<EOS
yum clean metadata --disablerepo=* --enablerepo=wakame-vdc-rhel6
yum update  -y     --disablerepo=* --enablerepo=wakame-vdc-rhel6
yum install -y wakame-vdc-example-1box-full-vmapp-config
EOS

chroot $1 $SHELL <<EOS
# add vzkernel entry
/opt/axsh/wakame-vdc/rpmbuild/helpers/edit-grub4vz.sh add
# edit boot order to use vzkernel as default.
/opt/axsh/wakame-vdc/rpmbuild/helpers/edit-grub4vz.sh enable
EOS
