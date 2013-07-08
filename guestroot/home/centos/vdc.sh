#!/bin/bash
#
# requires:
#  bash
#  screen
#

readonly SCREEN_NAME=vdc
readonly VDC_LOG_PATH=/var/log/wakame-vdc

function screen_it {
  local title=$1; shift
  local cmd="$@"
  local NL=`echo -ne '\015'`

  screen -L -r ${SCREEN_NAME} -x -X screen -t ${title}
  screen -L -r ${SCREEN_NAME} -x -p ${title} -X stuff "${cmd}$NL"
}

screen -L -d -m -S ${SCREEN_NAME} -t vdc -c ~/.screenrc

for component in collector dcmgr hva sta dolphin nwmongw; do
  screen_it ${component} "tail -F ${VDC_LOG_PATH}/${component}.log"
done

screen -x -r ${SCREEN_NAME}
