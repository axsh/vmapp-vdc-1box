function list_guestroot_tree() {
  local guestroot_dir=$(pwd)/guestroot
  [[ -d "${guestroot_dir}" ]] || return 0

  cd ${guestroot_dir}
  find . ! -type d | sed s,^\.,, | egrep -v '^/(.gitkeep|functions.sh)'
}

function generate_copyfile() {
  local guestroot_dir=$(pwd)/guestroot
  [[ -d "${guestroot_dir}" ]] || return 0

  echo "[INFO](copyfile) Generating copy.txt"
  while read line; do
    echo ${guestroot_dir}${line} ${line}
  done < <(list_guestroot_tree) > $(pwd)/copy.txt
  cat $(pwd)/copy.txt
}

generate_copyfile
