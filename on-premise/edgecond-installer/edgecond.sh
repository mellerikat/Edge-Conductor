#!/bin/bash

check_permission(){
  if [ `whoami` != 'root' ];then
      echo "Please run this script as root user or sudo"
      exit 1
  fi
}

check_permission

ABS_CURRNT_PATH=`readlink -f "${BASH_SOURCE:-$0}"`
ABS_CURRNT_DIR=`dirname $ABS_CURRNT_PATH`
cd $ABS_CURRNT_DIR


. ./env

help()
{
  echo "
Usage: edgecond.sh help
       edgecond.sh <command> [parameters]

Configure Edge Conductor

Commands:
  configure   Install packages and configure
  run         Run Edge Conductor
  stop        Stop Edge Conductor
  clear       Delete all saved data
  update      Update Edge Conductor
  version     Print current version
  config      Print current config

Run 'edgecond.sh COMMAND --help' for more information on a command.

"
  exit 2
}

func_configure()
{
  echo -e "\nConfig..."
  . ./scripts/configure.sh $@
  exit 0
}

func_run()
{
  echo -e "\nRun..."
  runuser -l $USER_NAME -c "docker compose --profile standard -f docker-stack.yml up -d"
  exit 0
}
func_stop()
{
  echo -e "\nstop..."
  runuser -l $USER_NAME -c "docker compose --profile standard -f docker-stack.yml down"
  exit 0
}

func_clear()
{
  echo -e "\nClear..."
  . ./scripts/clear.sh $@
  exit 0
}

func_update()
{
  . ./scripts/update.sh $@
  exit 0
}

func_version()
{
  echo ""
  runuser -l $USER_NAME -c "cat tag"
  exit 0
}

func_config()
{
  echo ""
  runuser -l $USER_NAME -c "cat ./config/.env.standard"
  exit 0
}


while :
do
  case "$1" in
    help)
      help
      ;;
    configure)
      func_configure "${*:2}"
      ;;
    run)
      func_run
      ;;
    stop)
      func_stop
    ;;
    clear)
      func_clear
      ;;
    update)
      func_update "${*:2}"
      ;;
    version)
      func_version
      ;;
    config)
      func_config
      ;;
    *)
      echo "Unexpected option: $1"
      help
      ;;
  esac
done
