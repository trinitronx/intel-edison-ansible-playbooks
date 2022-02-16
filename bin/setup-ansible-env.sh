#!/usr/bin/env bash
REPO_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )

# To use: export PIP_USE_SUDO=1
[[ -n "$PIP_USE_SUDO" && "$PIP_USE_SUDO" == '1' ]] && USE_SUDO='sudo' || USE_SUDO=''

# Configure AWS credentials
#. ~/secrets/aws_keys.sh

# set Rackspace credentials
#export RAX_CREDS_FILE=~/secrets/rackspace.ini

# Set Ansible Inventory (can be overridden by plays, cmdline, etc.)
export ANSIBLE_HOSTS=${REPO_BASE}/inventory

# Setup Ansible Dynamic Inventory script dependencies
$USE_SUDO pip list --format=columns | grep -q ipaddress || $USE_SUDO pip install -r "${REPO_BASE}"/inventory/requirements.txt
