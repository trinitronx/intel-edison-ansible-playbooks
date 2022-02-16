#!/bin/bash

docker_machine_state() {
  docker_machine_name="$1"
  docker-machine ls --filter "Name=$docker_machine_name" --format '{{.State}}'
}

errorout() {
  echo -e "\x1b[31;1mERROR:\x1b[0m ${1}"; exit 1
}

# Notes:
#  - Both docker-machine and boot2docker
#    are marked as Deprecated by the original authors
#  - Docker for Mac is now recommended instead
#  - Yet, sometimes a minimal Linux Docker VM is still useful!
#  - Luckily silver886 has a fork which appears to be updating the boot2docker.iso
#  - As of VirtualBox 6.1.28,
#    host-only networks are restricted to 192.168.56.0/21 by default
#    References:
#     - https://github.com/hashicorp/nomad/pull/11561
#     - https://www.virtualbox.org/manual/ch06.html#network_hostonly

# Create docker-machine 'dm' with:
#  - Docker v20.10.11
# Source: https://github.com/silver886/boot2docker/releases/tag/v20.10.11
BOOT2DOCKER_URL='https://github.com/silver886/boot2docker/releases/download/v20.10.12-rc1/boot2docker.iso'

docker-machine create --driver virtualbox \
  --virtualbox-boot2docker-url "$BOOT2DOCKER_URL" \
  --virtualbox-hostonly-cidr "192.168.56.100/21" \
  dm

eval $(docker-machine env dm)

DOCKER_MACHINE_NAME=$(docker-machine active 2>/dev/null)
[ -z $DOCKER_MACHINE_NAME ] && DOCKER_MACHINE_NAME=$(docker-machine active | head -n1)
[ -z $DOCKER_MACHINE_NAME ] && errorout "Cannot find active docker-machine name... make sure the VM is running"

echo "Creating vboxsf group INSIDE docker-machine VM: $DOCKER_MACHINE_NAME"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo addgroup -g 20 vboxsf"
echo "Adding docker user to vboxsf group"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo addgroup docker vboxsf"

echo "Starting VBoxService automount /Users shared folder"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo VBoxService --only-automount"
# TODO: Fix "magic"? automount path + uid / gid setup
# Reference:
#  -  https://github.com/docker/machine/blob/b170508bf44c3405e079e26d5fdffe35a64c6972/drivers/virtualbox/virtualbox.go#L445
docker-machine ssh $DOCKER_MACHINE_NAME "sudo umount /sf_Users"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo mkdir /Users; sudo mount -t vboxsf -o uid=$(id -u),gid=$(id -g) Users /Users"
docker-machine ssh $DOCKER_MACHINE_NAME "sudo mount -t vboxsf -o uid=$(id -u),gid=$(id -g) Users /Users"
