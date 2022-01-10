#!/bin/bash
#http://stackoverflow.com/questions/30605742/issues-getting-ansible-to-work-with-boot2docker
# To use Ansible in boot2docker, we must install python in boot2docker (it's based on Tiny Core Linux)
boot2docker ssh "wget http://www.tinycorelinux.net/6.x/x86/tcz/python.tcz && tce-load -i python.tcz && rm -f python.tcz"
