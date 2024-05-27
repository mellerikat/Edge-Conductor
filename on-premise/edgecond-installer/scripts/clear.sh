#! /bin/bash


delete_config(){
  echo "wait..."
  runuser -l $USER_NAME -c "docker compose -f docker-stack.yml down"
  sleep 2
  echo -e "delete imamges... "
  docker system prune -a -f
  sleep 2
  echo -e "delete account... "
  deluser --remove-home $USER_NAME
}


read -p "All saved data will be deleted. Do you want to continue? (y/n) " yn

# giving choices there tasks using
case $yn in
  [yY]* )
    delete_config
    ;;
  [nN]* )
    exit 0
    ;;
  *) exit ;;
esac

exit
