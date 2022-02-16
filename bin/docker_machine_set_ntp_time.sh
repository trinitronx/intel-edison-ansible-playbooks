#!/bin/bash

docker_machine_state() {
  docker_machine_name="$1"
  docker-machine ls --filter "Name=$docker_machine_name" --format '{{.State}}'
}


DOCKER_MACHINE_NAME=$(docker-machine active 2>/dev/null)
[ -z "$DOCKER_MACHINE_NAME" ] && DOCKER_MACHINE_NAME=$(docker-machine ls --filter 'driver=virtualbox' --format '{{.Name}}' | head -n1)

[[ "$(docker-machine status "$DOCKER_MACHINE_NAME")" != 'Running' ]] && docker-machine start "$DOCKER_MACHINE_NAME"

docker-machine ssh "$DOCKER_MACHINE_NAME"  'tce-load -wi ntpclient.tcz'
docker-machine ssh "$DOCKER_MACHINE_NAME"  'ntpclient -c 10 -i 1 -q 300 -l -d -h 0.amazon.pool.ntp.org'
