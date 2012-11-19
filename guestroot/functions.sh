# -*-Shell-script-*-
#
# requires:
#  bash
#  egrep, sed
#

## ^key="value"
function configure_keyval() {
  local config_path=$1 target_key="$2" target_val="$3"
  [[ -f ${config_path} ]] || { echo "no such file: ${config_path}" >&2; return 1; }

  egrep -q "^${target_key}=" ${config_path} && {
    sed -i "s,^${target_key}=.*,${target_key}=\"${target_val}\"", ${config_path}
  } || {
    echo "${target_key}=\"${target_val}\"" >> ${config_path}
  }

  # don't need strict checking
  egrep -q "^${target_key}=" ${config_path}
}

## ^line
function configure_line() {
  local config_path=$1 line="$2"
  [[ -f ${config_path} ]] || { echo "no such file: ${config_path}" >&2; return 1; }

  egrep -q "^${line}" ${config_path} && {
    sed -i "s,^${line}*,${line}", ${config_path}
  } || {
    echo "${line}" >> ${config_path}
  }
}
