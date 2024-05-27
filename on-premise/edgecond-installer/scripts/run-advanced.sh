#! /usr/bin/env sh

# Exit in case of error
set -e

[ ! -f ./config/.env.advanced ] && SERVER_PROTOCOL=http ./scripts/envsetup.sh --output-file=./config/.env.advanced

TAG=$(cat tag) \
PREFIX=$(id -u) \
PROFILE=advanced \
docker-compose \
--profile advanced \
--env-file ./config/.env.advanced \
-f docker-compose.yml \
config > docker-stack.yml

docker-compose --profile advanced -f docker-stack.yml "$@"
