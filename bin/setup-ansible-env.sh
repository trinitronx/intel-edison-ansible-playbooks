#!/usr/bin/env bash
REPO_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )

# Configure AWS credentials
#. ~/secrets/aws_keys.sh

# set Rackspace credentials
#export RAX_CREDS_FILE=~/secrets/rackspace.ini

# Set Ansible Inventory (can be overridden by plays, cmdline, etc.)
export ANSIBLE_HOSTS=${REPO_BASE}/inventory
