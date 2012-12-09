# -*-Shell-script-*-
#
# requires:
#  bash
#  ls
#

ls $(pwd)/plugins-enabled/ | while read plugin; do
  (. $(pwd)/plugins-enabled/${plugin})
done
