#!/bin/bash
# http://stackoverflow.com/questions/30605742/issues-getting-ansible-to-work-with-boot2docker

docker_machine_state() {
  docker_machine_name="$1"
  docker-machine ls --filter "Name=$docker_machine_name" --format '{{.State}}'
}

DOCKER_MACHINE_NAME=$(docker-machine active 2>/dev/null)
[ -z $DOCKER_MACHINE_NAME ] && DOCKER_MACHINE_NAME=$(docker-machine ls --filter 'driver=virtualbox' --format '{{.Name}}' | head -n1)

[[ "$(docker-machine status $DOCKER_MACHINE_NAME)" != 'Running' ]] && docker-machine start $DOCKER_MACHINE_NAME

# To use Ansible in docker-machine, we must install python in docker-machine VM (it's based on Tiny Core Linux)
echo "Installing qemu-arm-static to /usr/bin/qemu-arm-static INSIDE docker-machine VM: $DOCKER_MACHINE_NAME"
docker-machine ssh $DOCKER_MACHINE_NAME "wget http://www.tinycorelinux.net/6.x/x86/tcz/python.tcz && tce-load -i python.tcz && rm -f python.tcz"
