#!/bin/bash
#
# requires:
#  bash
#

hypervisor=${1:-kvm}
format=${2:-vmdk}

# real    5m37.951s
# user    2m25.709s
# sys     0m26.962s
time ./box-ctl.sh build ${hypervisor}

case "${format}" in
vmdk|vdi)
  # real    0m53.245s
  # user    0m4.873s
  # sys     0m17.294s
  time ./box-ctl.sh raw2${format} ${hypervisor}

  # real    4m14.319s
  # user    3m40.166s
  # sys     0m5.764s
  time ./box-ctl.sh dist_${format} ${hypervisor}
  ;;
esac
