USER_ID=$(id -u)
case $USER_ID in
 0)
   true
   ;;
 *)
   echo "\e[4;1;31mYou need to be login as root to perform this operation\e[0m"
   exit 1
   ;;
 esac




INFO(){
  echo -e "\e[1;32m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $1"
}

SUCC(){
  echo -e "\e[1;32m[SUCC] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $1"
}

FAIL(){
  echo -e "\e[1;31m[FAIL] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $1"

}