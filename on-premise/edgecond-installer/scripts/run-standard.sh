#! /usr/bin/env sh

# Exit in case of error
set -e

[ ! -f ./config/.env.standard ] && SERVER_PROTOCOL=http ./scripts/envsetup.sh --output-file=./config/.env.standard

TAG=$(cat tag) \
PREFIX=$(id -u) \
PROFILE=standard \
docker-compose \
--profile standard \
--env-file ./config/.env.standard \
-f docker-compose.yml \
config > docker-stack.yml

docker-compose --profile standard -f docker-stack.yml "$@"
