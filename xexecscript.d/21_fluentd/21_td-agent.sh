#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

chroot $1 $SHELL -ex <<EOS
  td_agent_version=1.1.13
  [[ -n "${td_agent_version}" ]] && {
    td_agent_version="-${td_agent_version}"
  }

  yum install -y \
     td_agent${td_agent_version} \
EOS

chroot $1 $SHELL -ex <<EOS
  chkconfig --list td-agent
  chkconfig td-agent on
EOS
