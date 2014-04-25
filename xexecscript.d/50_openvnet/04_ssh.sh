#!/bin/bash

set -e

case "${VDC_EDGE_NETWORKING}" in
openvnet) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<EOS
  sed -i -e 's/^#\(PubkeyAuthentication\)/\1/' /etc/ssh/sshd_config
  sed -i -e 's/^#\(AuthorizedKeysFile\)/\1/' /etc/ssh/sshd_config

  service sshd stop
  service sshd start
EOS
