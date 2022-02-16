#!/bin/bash
# From playbooks/dev_vm/README.md

docker_machine_state() {
  docker_machine_name="$1"
  docker-machine ls --filter "Name=$docker_machine_name" --format '{{.State}}'
}


DOCKER_MACHINE_NAME=$(docker-machine active 2>/dev/null)
[ -z "$DOCKER_MACHINE_NAME" ] && DOCKER_MACHINE_NAME=$(docker-machine ls --filter 'driver=virtualbox' --format '{{.Name}}' | head -n1)

SHARED_FOLDERS="$(VBoxManage showvminfo "$DOCKER_MACHINE_NAME"  --machinereadable | grep SharedFolder | tr '\r\n' ' ')"

#if ! [[ $SHARED_FOLDERS =~ .*Users.* ]]; then
#  if docker_machine_state $DOCKER_MACHINE_NAME | grep -qi 'Running' ; then
#    docker-machine stop $DOCKER_MACHINE_NAME
#  fi
#  VBoxManage sharedfolder add dm --name Users --hostpath /Users
#  VBoxManage setextradata $DOCKER_MACHINE_NAME VBoxInternal2/SharedFoldersEnableSymlinksCreate/Users 1
#fi

if ! [[ $SHARED_FOLDERS =~ .*rpcm.* ]]; then
  if docker_machine_state "$DOCKER_MACHINE_NAME" | grep -qi 'Running' ; then
    docker-machine stop "$DOCKER_MACHINE_NAME"
  fi
  VBoxManage sharedfolder add "$DOCKER_MACHINE_NAME" --name rpcm --hostpath /usr/local/rpcm
  VBoxManage setextradata "$DOCKER_MACHINE_NAME" VBoxInternal2/SharedFoldersEnableSymlinksCreate/rpcm 1
fi

#if ! [[ $SHARED_FOLDERS =~ .*x11-fwd.* ]]; then
#  if docker_machine_state $DOCKER_MACHINE_NAME | grep -qi 'Running' ; then
#    docker-machine stop $DOCKER_MACHINE_NAME
#  fi
#  VBoxManage sharedfolder add dm --name x11-fwd --hostpath $(realpath $(dirname $DISPLAY))
#  VBoxManage setextradata $DOCKER_MACHINE_NAME VBoxInternal2/SharedFoldersEnableSymlinksCreate/x11-fwd 1
#fi

[[ "$(docker-machine status "$DOCKER_MACHINE_NAME")" != 'Running' ]] && docker-machine start "$DOCKER_MACHINE_NAME"

docker-machine ssh "$DOCKER_MACHINE_NAME" "[ -d /usr/local/rpcm ] || sudo mkdir -p /usr/local/rpcm"
docker-machine ssh "$DOCKER_MACHINE_NAME" "sudo mount -t vboxsf -o uid=$(id -u),gid=$(id -g) rpcm /usr/local/rpcm"
#docker-machine ssh $DOCKER_MACHINE_NAME "[ -d /Users ] || sudo mkdir -p /Users"
#docker-machine ssh $DOCKER_MACHINE_NAME "sudo mount -t vboxsf -o uid=$(id -u),gid=$(id -g) Users /Users"

# VBox Shared Folder mount (does NOT support file ACLs, and did not work for socket file)
#docker-machine ssh $DOCKER_MACHINE_NAME "[ -d /tmp/.X11-unix ] || sudo mkdir -p /tmp/.X11-unix"
#docker-machine ssh $DOCKER_MACHINE_NAME "sudo mount -t vboxsf -o uid=$(id -u),gid=$(id -g),rw,acl x11-fwd /tmp/.X11-unix"

if [ -n "$DISPLAY" ] && [ -x "$(which docker-machine-nfs)" ]; then
#  docker-machine-nfs $DOCKER_MACHINE_NAME --shared-folder=/Users --mount-opts="rw,acl,async,nolock,vers=3,udp,noatime,actimeo=1"
  docker-machine ssh "$DOCKER_MACHINE_NAME" "[ -d \"$(realpath "$(dirname "$DISPLAY")")\" ] || sudo mkdir -p \"$(realpath "$(dirname "$DISPLAY")")\""
  docker-machine-nfs "$DOCKER_MACHINE_NAME" --shared-folder=/Users --shared-folder="$(realpath "$(dirname "$DISPLAY")")" --mount-opts="rw,acl,async,nolock,vers=3,udp,noatime,actimeo=1"
fi
