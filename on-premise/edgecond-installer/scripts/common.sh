#! /bin/bash


login_registry(){
  docker login --username AWS --password $(aws ecr get-login-password --region ap-northeast-2) ${DOCKER_REGISTRY}
}


download_image(){
  echo -e "\nDownload images..."
  sleep 1
  login_registry
  if [[ $(aws ecr list-images --repository-name ecr-repo-an2-meerkat-prod/ai-advisor/edge-conductor/backend | grep $TAG_VERSION | wc -l) -eq 0 ]]; then
    echo "Not found edge_conductor-backend image. Check option --version: $TAG_VERSION"
    exit 1
  fi
  if [[ $(aws ecr list-images --repository-name ecr-repo-an2-meerkat-prod/ai-advisor/edge-conductor/frontend | grep $TAG_VERSION | wc -l) -eq 0 ]]; then
      echo "Not found edge_conductor-frontend image. Check option --version: $TAG_VERSION"
      exit 1
    fi
  docker pull ${DOCKER_REGISTRY}/ecr-repo-an2-meerkat-prod/ai-advisor/edge-conductor/backend:$TAG_VERSION
  docker pull ${DOCKER_REGISTRY}/ecr-repo-an2-meerkat-prod/ai-advisor/edge-conductor/frontend:$TAG_VERSION
  docker pull ${DOCKER_REGISTRY}/ecr-repo-an2-meerkat-prod/ai-advisor/edge-conductor/mysql:8.0.21
  docker pull registry:2.8.2
  docker pull quay.io/signalfx/splunk-otel-collector:0.67.0
}


init_config(){
  echo -e "\nCopy config files..."
  sleep 1
  for temp in config scripts docker-compose.yml; do
      cp -Rf ./$temp "$USER_HOME/"
      chown -R "$USER_NAME":"$USER_GROUP" "$USER_HOME/$temp"
  done
}


update_config(){
  echo -e "\nUpdate config files..."
  sleep 1
  USER_NAME_UID=$(runuser -l $USER_NAME -c "id -u")
  runuser -l $USER_NAME -c "echo $TAG_VERSION > tag"
  runuser -l $USER_NAME -c "export SERVER_PROTOCOL=http;./scripts/envsetup.sh --template=./config/.env.template --output-file=./config/.env.standard"
  runuser -l $USER_NAME -c "export TAG=$TAG_VERSION;export PREFIX=$USER_NAME_UID;export PROFILE=standard;export DOCKER_REGISTRY=$DOCKER_REGISTRY/ecr-repo-an2-meerkat-prod/;docker compose --profile standard --env-file ./config/.env.standard -f docker-compose.yml config -o docker-stack.yml"
}