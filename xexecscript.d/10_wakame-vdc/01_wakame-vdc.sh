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
  # in order escape below error
  # > Error: Cannot retrieve metalink for repository: epel. Please verify its path and try again
  #
  sed -i \
   -e 's,^#baseurl,baseurl,' \
   -e 's,^mirrorlist=,#mirrorlist=,' \
   -e 's,http://download.fedoraproject.org/pub/epel/,http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/,' \
   /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo

  yum clean metadata --disablerepo=* --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6
  yum update  -y     --disablerepo=* --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6
EOS

chroot $1 $SHELL -ex <<'EOS'
  releasever=$(< /etc/yum/vars/releasever)

  case "${releasever}" in
    6.[0-5])
      # wakame-vdc-ruby depends on libyaml.
      # TODO: handle arch type.
      yum install -y http://ftp.jaist.ac.jp/pub/Linux/CentOS/6.6/os/x86_64/Packages/libyaml-0.1.3-1.4.el6.x86_64.rpm
      ;;
  esac
EOS
