#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

# disable updates repository
#chroot $1 $SHELL -ex <<EOS
#  sed -i 's,\[updates\],[updates]\nenabled=0,' /etc/yum.repos.d/CentOS-Base.repo
#EOS
#
chroot $1 $SHELL -ex <<EOS
  cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.saved
  sed 's,^#baseurl=.*,baseurl=${baseurl},' /etc/yum.repos.d/CentOS-Base.repo.saved \
   | sed -n '1,/^\[updates\]/p' \
   | egrep -v  "^\[updates\]" > /etc/yum.repos.d/CentOS-Base.repo
EOS
