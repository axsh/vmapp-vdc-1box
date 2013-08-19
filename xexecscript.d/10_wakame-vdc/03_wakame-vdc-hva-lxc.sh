#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

case "${VDC_HYPERVISOR}" in
lxc) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<'EOS'
  pkg_names="
   wakame-vdc-hva-lxc-vmapp-config
  "

  for pkg_name in ${pkg_names}; do
    yum search ${pkg_name} | egrep -q ${pkg_name} || continue
    yum install -y ${pkg_name}
  done

  if [ -f /etc/wakame-vdc/convert_specs/load_balancer.yml ]; then
    sed -i "s,hypervisor: .*,hypervisor: 'lxc'," /etc/wakame-vdc/convert_specs/load_balancer.yml
  fi

  echo "none                    /cgroup                 cgroup  defaults        0 0" >> /etc/fstab
  [[ -d /var/lib/lxc ]] || mkdir /var/lib/lxc
EOS
