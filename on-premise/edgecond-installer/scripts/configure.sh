#! /bin/bash

. ./scripts/common.sh

TAG_VERSION="latest"

create_account(){
  if [[ ! -d "$USER_HOME" ]]; then
    mkdir --parents $USER_HOME
  fi

  sleep 1
  if [[ $(cat /etc/group | grep $USER_GROUP | wc -l) -eq 0 ]]; then
    echo "Create group : $USER_GROUP"
    groupadd -r $USER_GROUP
  else
    echo "Exists group : $USER_GROUP"
  fi

  sleep 1
  if id -u "$USER_NAME" >/dev/null 2>&1; then
    echo "Group($USER_NAME) exists"
  else
    echo "Create user : $USER_NAME"
    useradd -g $USER_GROUP -r -d $USER_HOME $USER_NAME
    chown -R $USER_NAME:$USER_GROUP $USER_HOME
  fi
}

install_python3(){
  echo -e "\nInstall python3"

  if which python3 > /dev/null 2>&1; then
    echo "Current Python3 : `python3 --version`"
  else
    echo "Not found Python3."
    echo "install python3..."
    sudo apt install -y python3
  fi
  sleep 1

  if which pip > /dev/null 2>&1; then
    echo "Current pip : `pip3 --version`"
  else
    echo "Not found pip. install pip..."
    apt install -y python3-pip
    echo "Current pip : `pip3 --version`"
  fi
  sleep 1
}


install_awscli(){
  if which aws > /dev/null 2>&1; then
    echo "Current awscli : `aws --version`"
  else
    echo "Not found awscli. install awscli..."
    pip install awscli
    echo "awscli : `aws --version`"
  fi
  sleep 1
}

install_docker(){

  echo -e "\nUninstall all conflicting packages"
  sleep 1
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do apt-get remove $pkg; done

  # 1. Set up Docker's apt repository.
  echo -e "\nAdd Docker's official GPG key"
  sleep 1
  apt-get update
  apt-get install -y ca-certificates curl gnupg jq
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  chmod a+r /etc/apt/keyrings/docker.gpg

  echo -e "\nAdd the repository to Apt sources"
  sleep 1
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update

  # 2. Install the Docker packages
  echo -e "\nInstall the Docker packages"
  sleep 1
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # 3. Add group of docker
  if [[ $(cat /etc/group | grep docker | wc -l) -eq 0 ]]; then
    groupadd docker
  else
    echo "Exists group : docker"
  fi

  usermod -aG docker $USER_NAME
  # newgrp docker
}

# /etc/apt/keyrings/docker.gpg

install_packages(){
  install_python3
  install_awscli
  install_docker
}


get_local_ip_address(){
  ip route get 1.2.3.4 | awk '{print $7}'
}


usage() {
  echo ""
  echo "Configure Edge Conductor."
  echo ""
  echo "usage: $0 configure [--help] --registry string --access_key string --secret_key string --version string"
  echo ""
  echo "  --registry              repository of docker images"
  echo "                          ex) --registry docker.io"
  echo "  --access_key            access key for download docker image"
  echo "                          ex) --access_key AKIAIOSFODNN7EXAMPLE)"
  echo "  --secret_key            secret key for download docker image"
  echo "                          ex) --secret_key wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY)"
  echo "  --version               version of released"
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
elif [[ -z $version ]]; then
  echo "Error: Missing parameter --version" >&2
  usage
  exit 2
fi

export DOCKER_REGISTRY=$registry
export AWS_ACCESS_KEY_ID=$access_key
export AWS_SECRET_ACCESS_KEY=$secret_key
export AWS_DEFAULT_REGION=ap-northeast-2
if [[ ! -z $version ]]; then
  TAG_VERSION=$version
fi

sleep 1

# 1. create service account
create_account

# 2. Install packages
install_packages

# 3. pull docker image
download_image

# 4. copy to home
init_config
update_config

echo -e "\nCompleted configure"
echo "Run command : ./edgecond.sh run"

exit 0