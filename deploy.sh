#!/bin/bash

set -e

LOBITA_HOST="lobita.ddns.net"
WORK_DIR="lobita-web"

if [ -n "$1" ]; then
  DEPLOY_USER="$1"
else
  DEPLOY_USER=$(whoami)
fi

sshcmd() {
  ssh ${DEPLOY_USER}@${LOBITA_HOST} "cd ~/${WORK_DIR} && $@"
}

sshcmd git checkout master
sshcmd git pull origin master
sshcmd docker-compose build
sshcmd docker-compose up -d
sshcmd docker image prune -f

exit 0
