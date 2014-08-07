#!/bin/bash
#
# requires:
#  bash
#
set -e

declare chroot_dir=$1

# via https://github.com/axsh/wakame-vdc/blob/master/vmapp/build.sh.d/jre6.sh

## http://java.com/en/download/manual_v6.jsp
declare jre6_ver=${jre6_ver:-1.6.0_38}
declare jre6_uri_32="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71302"
declare jre6_uri_64="http://javadl.sun.com/webapps/download/AutoDL?BundleId=71304"

declare jre6_name=${jre6_name:-jre-6u-linux-rpm.bin}
declare jre6_path=${jre6_path:-/tmp/${jre6_name}}

##
function presetup_jre6() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  local jre6_location=
  case "$(arch)" in
  i*86)
    jre6_location=${jre6_uri_32}
    ;;
  x86_64)
    jre6_location=${jre6_uri_64}
    ;;
  esac

  run_in_target ${chroot_dir} curl -fSkL --retry 3 \"${jre6_location}\" -o ${jre6_path}
}

function prepare_jre6() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  run_in_target ${chroot_dir} yum install -y which
}

function cleanup_jre6() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  run_in_target ${chroot_dir} rm -f ${jre6_path}
}

function install_jre6() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  presetup_jre6 ${chroot_dir}
  prepare_jre6  ${chroot_dir}
  run_in_target ${chroot_dir} "cd /tmp && sh ${jre6_path}"
  cleanup_jre6  ${chroot_dir}
}

# via https://github.com/axsh/wakame-vdc/blob/master/vmapp/build.sh.d/cassandra.sh

function render_datastax_repo() {
  cat <<-'EOS'
	[datastax]
	name= DataStax Repo for Apache Cassandra
	baseurl=http://rpm.datastax.com/community
	enabled=1
	gpgcheck=0
	EOS
}

function install_datastax_repo() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  render_datastax_repo > ${chroot_dir}/etc/yum.repos.d/datastax.repo
}

function presetup_cassandra() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  install_epel          ${chroot_dir}
  install_datastax_repo ${chroot_dir}
  install_jre6          ${chroot_dir}
}

function install_dsc_rpm() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  run_in_target ${chroot_dir} yum install -y http://rpm.datastax.com/community/noarch/dsc1.1-1.1.9-1.noarch.rpm
}

function configure_cassandra_jre() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  run_in_target ${chroot_dir} alternatives --install /usr/bin/java java /usr/java/jre${jre6_ver}/bin/java 20000
}

function unprevent_cassandra_starting() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  unprevent_daemons_starting ${chroot_dir} cassandra
}

function configure_cassandra() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  configure_cassandra_jre      ${chroot_dir}
  unprevent_cassandra_starting ${chroot_dir}
}

function verify_cassandra_jre() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  # $ java -version
  # java version "1.6.0_38"
  # Java(TM) SE Runtime Environment (build 1.6.0_38-b05)
  # Java HotSpot(TM) 64-Bit Server VM (build 20.13-b02, mixed mode)
  #
  # *** "java -version" shows version info to STDERR. ***
  #
  run_in_target ${chroot_dir} java -version 2>&1 | egrep -w "java version \"${jre6_ver}\""
  run_in_target ${chroot_dir} chkconfig --list cassandra
}

function verify_cassandra() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  verify_cassandra_jre ${chroot_dir}
}

function install_cassandra() {
  local chroot_dir=$1
  [[ -d "${chroot_dir}" ]] || { echo "[ERROR] directory not found: ${chroot_dir} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  presetup_cassandra  ${chroot_dir}
  install_dsc_rpm     ${chroot_dir}
  configure_cassandra ${chroot_dir}
  verify_cassandra    ${chroot_dir}
}

# main

### [2014/08/07] disable cassandra installation
### install_cassandra ${chroot_dir}
