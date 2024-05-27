#! /usr/bin/env sh

# Exit in case of error
set -e

[ ! -f ./config/.env.basic ] && SERVER_PROTOCOL=http ./scripts/envsetup.sh --output-file=./config/.env.basic

TAG=$(cat tag) \
PREFIX=$(id -u) \
PROFILE=basic \
docker-compose \
--profile basic \
--env-file ./config/.env.basic \
-f docker-compose.yml \
config > docker-stack.yml

docker-compose --profile basic -f docker-stack.yml "$@"
