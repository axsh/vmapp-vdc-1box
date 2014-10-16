#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<'EOS'
  rpm -Uvh http://dlc.wakame.axsh.jp.s3-website-us-east-1.amazonaws.com/epel-release
  # workaround 2014/10/17
  #
  # in order escape below erro
  # > Error: Cannot retrieve metalink for repository: epel. Please verify its path and try again
  #
  sed -i 's,^#baseurl,baseurl,; s,^mirrorlist=,#mirrorlist=,;' /etc/yum.repos.d/epel.repo

  yum clean metadata --disablerepo=* --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6
  yum update  -y     --disablerepo=* --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6
EOS
