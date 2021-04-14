INFO(){
  echo -e "\e[1;32m[INFO] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $1"
}

SUCC(){
  echo -e "\e[1;32m[SUCC] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $1"
}

FAIL(){
  echo -e "\e[1;31m[FAIL] \e[1;34m[$COMPONENT] \e[1;33m[$(date '+%F %T')]\e[0m $1"

}