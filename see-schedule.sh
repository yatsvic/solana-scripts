#!/bin/bash 

pushd `dirname ${0}` > /dev/null || exit 1
source ./env.sh

#from https://stackoverflow.com/a/58617630OD
function durationToSeconds () {
  set -f
  normalize () { echo $1 | tr '[:upper:]' '[:lower:]' | tr -d "\"\\\'" | sed 's/years\{0,1\}/y/g; s/months\{0,1\}/m/g; s/days\{0,1\}/d/g; s/hours\{0,1\}/h/g; s/minutes\{0,1\}/m/g; s/min/m/g; s/seconds\{0,1\}/s/g; s/sec/s/g;  s/ //g;'; }
  local value=$(normalize "$1")
  local fallback=$(normalize "$2")

  echo $value | grep -v '^[-+*/0-9ydhms]\{0,30\}$' > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    >&2 echo Invalid duration pattern \"$value\"
  else
    if [ "$value" = "" ]; then
      [ "$fallback" != "" ] && durationToSeconds "$fallback"
    else
      sedtmpl () { echo "s/\([0-9]\+\)$1/(0\1 * $2)/g;"; }
      local template="$(sedtmpl '\( \|$\)' 1) $(sedtmpl y '365 * 86400') $(sedtmpl d 86400) $(sedtmpl h 3600) $(sedtmpl m 60) $(sedtmpl s 1) s/) *(/) + (/g;"
      echo $value | sed "$template" | bc
    fi
  fi
  set +f
}

NOW_SEC=`date +%s`
EPOCH_INFO=`solana --url=localhost epoch-info`
SCHEDULE=`solana --url=localhost leader-schedule | grep ${SOLANA_VALIDATOR_PUB_KEY}`

FIRST_SLOT=`echo -e "$EPOCH_INFO" | grep "Epoch Slot Range: " | cut -d '[' -f 2 | cut -d '.' -f 1`
LAST_SLOT=`echo -e "$EPOCH_INFO" | grep "Epoch Slot Range: " | cut -d '[' -f 2 | cut -d '.' -f 3 | cut -d ')' -f 1`
CURRENT_SLOT=`echo -e "$EPOCH_INFO" | grep "Slot: " | cut -d ':' -f 2 | cut -d ' ' -f 2`
EPOCH_LEN_TEXT=`echo -e "$EPOCH_INFO" | grep "Completed Time" | cut -d '/' -f 2 | cut -d '(' -f 1`
EPOCH_LEN_SEC=$(durationToSeconds "${EPOCH_LEN_TEXT}")
SLOT_LEN_SEC=`echo "scale=10; ${EPOCH_LEN_SEC}/(${LAST_SLOT}-${FIRST_SLOT})" | bc`
START_SEC=`echo "" | bc`
echo "$EPOCH_INFO"
echo

function slotDate () {
  local SLOT=${1}
  local SLOT_DIFF=`echo "${SLOT}-${CURRENT_SLOT}" | bc`
  local DELTA=`echo "(${SLOT_LEN_SEC}*${SLOT_DIFF})/1" | bc`
  local SLOT_DATE_SEC=`echo "${NOW_SEC} + ${DELTA}" | bc`
  local DATE_TEXT=`date --iso-8601=seconds -d @${SLOT_DATE_SEC}`
  echo $DATE_TEXT
}

echo start `slotDate ${FIRST_SLOT}`
echo "${SCHEDULE}" | sed 's/|/ /' | awk '{print $1}' | while read in; do echo "$in `slotDate $in`"; done
echo end `slotDate ${LAST_SLOT}`

popd > /dev/null || exit 1

