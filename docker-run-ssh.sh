#!/bin/bash

# "docker run" with SSH Agent Forwarding for boot2docker

# QuickStart:
#   1. Download to ~/bin/docker-run-ssh and chmod +x it
#   2. docker-run-ssh [normal args to docker run...]

# Use a unique ssh socket name per-invocation of this script
SSH_SOCK=boot2docker.$$.ssh.socket

# ssh into boot2docker with agent forwarding
ssh -i ~/.ssh/id_boot2docker \
    -o StrictHostKeyChecking=no \
    -o IdentitiesOnly=yes \
    -o UserKnownHostsFile=/dev/null \
    -o LogLevel=quiet \
    -p 2022 docker@localhost \
    -A -M -S $SSH_SOCK -f -n \
    tail -f /dev/null

# get the agent socket path from the boot2docker vm
B2D_AGENT_SOCK=$(ssh -S $SSH_SOCK docker@localhost echo \$SSH_AUTH_SOCK)

# mount the socket (from the boot2docker vm) onto the docker container
# and set the ssh agent environment variable so ssh tools pick it up
docker run \
    -v $B2D_AGENT_SOCK:/ssh-agent \
    -e "SSH_AUTH_SOCK=/ssh-agent" \
    "$@"

# we're done; kill off the boot2docker ssh agent
ssh -S $SSH_SOCK -O exit docker@localhost
