#!/bin/bash

SCRIPT=$(basename $0)
REPO_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )

# If using docker-machine + VirtualBox...
# Hack for forcing mdns / Bonjour / Zeroconf DNS resolution to be done on the Host machine running the VM
# Resolve from docker-machine VM -> OSX Host -> mDNS (local LAN segment which edisons are attached to)
DOCKER_MACHINE_NAME=$(docker-machine active 2>/dev/null)

if [ -n "${DOCKER_MACHINE_NAME}" ]; then
  VBoxManage modifyvm $DOCKER_MACHINE_NAME --natdnshostresolver1 on
fi

# First run must SSH in as root with asked password (we assume you have set a password first)
ansible-playbook -i ${REPO_BASE}/inventory/hosts ${REPO_BASE}/base.yml -vv --diff --user=root --ask-pass
