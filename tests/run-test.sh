#!/usr/bin/env bash

WORKSPACE="$(cd "$(dirname "$0")" && pwd -P)" #"
BUILDSPACE=${TRAVIS_BUILD_DIR:-"${WORKSPACE}/tmp"}

function checks(){
  printf "[$(date +"%Y-%m-%d %T")] Check quality with Ansible lint ...\n"
  ansible-lint ${1}

  printf "[$(date +"%Y-%m-%d %T")] Check syntax with Ansible ..."
  ansible-playbook ${1} -i ${2} --syntax-check
}

function prepare(){
  ln -sf -T ${WORKSPACE}/.. ${1}/roles/collectd

  echo centos-08 >> ${1}/inventory
  #echo debian-10 >> ${1}/inventory
}

set -e

export ANSIBLE_HASH_BEHAVIOUR="merge"
export ANSIBLE_ROLES_PATH="${BUILDSPACE}/roles"

mkdir -p ${ANSIBLE_ROLES_PATH}
prepare ${BUILDSPACE}
checks ${WORKSPACE}/test.yml ${BUILDSPACE}/inventory


printf "[$(date +"%Y-%m-%d %T")] Run tests ...\n"
#docker run -d --tmpfs /run --tmpfs /tmp --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro --name centos-07 el-7
ansible-playbook ${WORKSPACE}/test.yml -i ${BUILDSPACE}/inventory --become
