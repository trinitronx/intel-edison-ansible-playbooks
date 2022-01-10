#!/bin/bash

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
BOOT2DOCKER_URL='https://github.com/silver886/boot2docker/releases/download/v20.10.11/boot2docker.iso'

docker-machine create --driver virtualbox \
  --virtualbox-boot2docker-url "$BOOT2DOCKER_URL" \
  --virtualbox-hostonly-cidr "192.168.56.100/24" \
  dm
