#!/bin/bash
#
# requires:
#  bash
#  yum
#
set -e

echo "doing execscript.sh: $1"

case "${VDC_HYPERVISOR}" in
kvm) ;;
*) exit 0 ;;
esac

chroot $1 $SHELL -ex <<'EOS'
  pkg_names="
   wakame-vdc-hva-kvm-vmapp-config
  "

  for pkg_name in ${pkg_names}; do
    yum search  --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6    ${pkg_name} | egrep -q ${pkg_name} || continue
    yum install --enablerepo=wakame-vdc-rhel6 --enablerepo=wakame-3rd-rhel6 -y ${pkg_name}
  done

  if [ -f /etc/wakame-vdc/convert_specs/load_balancer.yml ]; then
    sed -i "s,hypervisor: .*,hypervisor: 'kvm'," /etc/wakame-vdc/convert_specs/load_balancer.yml
  fi
EOS
