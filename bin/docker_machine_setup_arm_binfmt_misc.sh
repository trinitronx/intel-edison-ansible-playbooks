#!/bin/bash
# From playbooks/dev_vm/README.md

docker_machine_state() {
  docker_machine_name="$1"
  docker-machine ls --filter "Name=$docker_machine_name" --format '{{.State}}'
}


DOCKER_MACHINE_NAME=$(docker-machine active 2>/dev/null)
[ -z $DOCKER_MACHINE_NAME ] && DOCKER_MACHINE_NAME=$(docker-machine ls --filter 'driver=virtualbox' --format '{{.Name}}' | head -n1)

SHARED_FOLDERS="$(VBoxManage showvminfo $DOCKER_MACHINE_NAME  --machinereadable | grep SharedFolder | tr '\r\n' ' ')"

[[ "$(docker-machine status $DOCKER_MACHINE_NAME)" != 'Running' ]] && docker-machine start $DOCKER_MACHINE_NAME

echo "Installing qemu-arm-static to /usr/bin/qemu-arm-static INSIDE docker-machine VM: $DOCKER_MACHINE_NAME"

docker-machine ssh $DOCKER_MACHINE_NAME "sudo docker run --rm mazzolino/qemu-arm-static | sudo tee /usr/bin/qemu-arm-static" > /dev/null
docker-machine ssh $DOCKER_MACHINE_NAME "sudo chmod u+x /usr/bin/qemu-arm-static"
docker-machine ssh $DOCKER_MACHINE_NAME "mount | grep -q binfmt_misc || sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc"
docker-machine ssh $DOCKER_MACHINE_NAME "[ -f /proc/sys/fs/binfmt_misc/arm ] || echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' | sudo tee /proc/sys/fs/binfmt_misc/register"

# Test that qemu-arm-static is setup via binfmt_misc by running a test ARM container
docker-machine ssh $DOCKER_MACHINE_NAME "docker run --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static resin/armv7hf-debian echo 'hello from ARM container'"
docker-machine ssh $DOCKER_MACHINE_NAME "docker run --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static resin/armv7hf-debian uname -a"
