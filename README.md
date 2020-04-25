intel-edison-ansible-playbooks
==============================

This repository contains all of the Ansible-based
playbooks used for Intel Edison staging activities

The basic directory layout mostly follows [Ansible's Best
Practices](http://www.ansibleworks.com/docs/playbooks_best_practices.html).

    ops-ansible-playbooks/
    |-- ansible.cfg         # The main ansible configuration file.
    |-- bin/                # Generic utility scripts used by Ansible
    |-- inventory/          # All inventory file and scripts must be here.
    |   `-- group_vars/    # Variables to apply to 'groups' go here.
    |   `-- host_vars/     # Variables to apply to individual hosts go here.
    |-- library/            # Custom or non-core modules go here.
    |-- playbooks/          # All of our playbooks go in sub-directories here.
    `-- roles/             # All actual role code goes here.

A LyraPhase / 37Om specific style guide is located in the [docs](/docs/STYLE_GUIDE.md/)
