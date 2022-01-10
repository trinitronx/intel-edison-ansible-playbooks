#!/bin/bash
#http://stackoverflow.com/questions/30605742/issues-getting-ansible-to-work-with-boot2docker
# To use Ansible in docker-machine, we must install python in docker-machine VM (it's based on Tiny Core Linux)
docker-machine ssh "wget http://www.tinycorelinux.net/6.x/x86/tcz/python.tcz && tce-load -i python.tcz && rm -f python.tcz"
