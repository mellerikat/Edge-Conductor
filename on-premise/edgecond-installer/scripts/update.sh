#! /bin/bash

. ./scripts/common.sh

usage() {
  echo ""
  echo "Update Edge Conductor or Show list of released versions"
  echo ""
  echo "usage: $0 update [--help] --registry string --access_key string --secret_key string [--list_upgradable]"
  echo ""
  echo "  --registry              repository of docker images"
  echo "                          ex) --registry docker.io"
  echo "  --access_key            access key for download docker image"
  echo "                          ex) --access_key AKIAIOSFODNN7EXAMPLE)"
  echo "  --secret_key            secret key for download docker image"
  echo "                          ex) --secret_key wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY)"
  echo "  --list_upgradable       Show list of released versions"
  echo "  --help                  show this help message and exit"
  echo ""
}

while [ $# -gt 0 ]; do
  if [[ $1 == "--help" ]]; then
      usage
      exit 0
  elif [[ $1 == "--"* ]]; then
      v="${1/--/}"
      declare "$v"="$2"
      shift
  fi
  shift
done

if [[ -z $registry ]]; then
  echo "Error: Missing parameter --registry" >&2
  usage
  exit 2
elif [[ -z $access_key ]]; then
  echo "Error: Missing parameter --access_key" >&2
  usage
  exit 2
elif [[ -z $secret_key ]]; then
  echo "Error: Missing parameter --secret_key" >&2
  usage
  exit 2
fi

export DOCKER_REGISTRY=$registry
export AWS_ACCESS_KEY_ID=$access_key
export AWS_SECRET_ACCESS_KEY=$secret_key
export AWS_DEFAULT_REGION=ap-northeast-2

sleep 1

echo -e "\nList of upgradable versions"
aws ecr list-images --repository-name ecr-repo-an2-meerkat-prod/ai-advisor/edge-conductor/backend --output json | jq -r '.imageIds[].imageTag' | sort
echo ""

if [[ -v list_upgradable ]]; then
  exit 0
fi

echo "Current versions : $(runuser -l $USER_NAME -c "cat tag")"
echo ""

read -p "Please input one the list of upgradeable versions : " TAG_VERSION

[[ -z "${TAG_VERSION}" ]] && exit 1

echo -e "\nUpdate..."

update_docker(){
  download_image
  update_config
}

update_docker

echo "Run command : ./edgecond.sh stop && ./edgecond.sh run"
