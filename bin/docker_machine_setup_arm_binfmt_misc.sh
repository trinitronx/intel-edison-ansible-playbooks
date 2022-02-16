#!/bin/bash
# From playbooks/dev_vm/README.md

docker_machine_state() {
  docker_machine_name="$1"
  docker-machine ls --filter "Name=$docker_machine_name" --format '{{.State}}'
}


DOCKER_MACHINE_NAME=$(docker-machine active 2>/dev/null)
[ -z "$DOCKER_MACHINE_NAME" ] && DOCKER_MACHINE_NAME=$(docker-machine ls --filter 'driver=virtualbox' --format '{{.Name}}' | head -n1)

[[ "$(docker-machine status "$DOCKER_MACHINE_NAME")" != 'Running' ]] && docker-machine start "$DOCKER_MACHINE_NAME"

echo "Registering qemu-* binfmt_misc handlers INSIDE docker-machine VM: $DOCKER_MACHINE_NAME"

docker-machine ssh "$DOCKER_MACHINE_NAME" "sudo docker run --privileged --rm docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64"
docker-machine ssh "$DOCKER_MACHINE_NAME" "mount | grep -q binfmt_misc || sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc"
