#!/bin/bash

#save="$(bash echo.sh)"
#echo "$save"
touch save.txt
BLUE='\033[95m'
NC='\033[0m'
echo "HOSTNAME =  $(hostname)"
echo "TIMEZONE =  $(cat /etc/timezone) \"UTC\" $(date +"%Z")"
echo "USER =  $(whoami)"
echo "OS = $(hostnamectl | grep 'Operating System' | awk '{print $3"  "$4" "$5}')"
echo "DATE = $(date +%"d %B %Y %T")"
echo "UPTIME = $(uptime -p)"
echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
echo "IP = $(hostname -I | awk '{print $1}')"
echo "MASK = $(ifconfig | grep $(hostname -I | awk '{print $1}') | awk '{print $4}')"
echo "GATEWAY = $(ip route | grep default | awk '{print $3}')"
echo "RAM_TOTAL = $(free | grep 'Mem' | awk '{printf "%.3f GB", $2/(1024*1024)}')"
echo "RAM_USED = $(free | grep 'Mem' | awk '{printf "%.3f GB", $3/(1024*1024)}')"
echo "RAM_FREE = $(free | grep 'Mem' | awk '{printf "%.3f GB", $4/(1024*1024)}')"
echo "SPACE_ROOT = $(df -BK | grep '/$' | awk '{printf "%.2f MB", $2 / 1024}')"
echo "SPACE_ROOT_USED = $(df -BK | grep '/$' | awk '{printf "%.2f MB", $3 / 1024}')"
echo "SPACE_ROOT_FREE="SPACE_ROOT_FREE = $(df -BK | grep '/$' | awk '{printf "%.2f MB", $4 / 1024}')""

read -r -p "Do you want to save the data to a file? Y/N: " answer

if [[ $answer = "Y"  || $answer = "y" ]];
then
    echo "HOSTNAME =  $(hostname)" >> save.txt
    echo "TIMEZONE =  $(cat /etc/timezone) \"UTC\" $(date +"%Z")" >> save.txt
    echo "USER =  $(whoami)" >> save.txt
    echo "OS = $(hostnamectl | grep 'Operating System' | awk '{print $3"  "$4" "$5}')" >> save.txt
    echo "DATE = $(date +%"d %B %Y %T")" >> save.txt
    echo "UPTIME = $(uptime -p)" >> save.txt
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')" >> save.txt
    echo "IP = $(hostname -I | awk '{print $1}')" >> save.txt
    echo "MASK = $(ifconfig | grep $(hostname -I | awk '{print $1}') | awk '{print $4}')" >> save.txt
    echo "GATEWAY = $(ip route | grep default | awk '{print $3}')" >> save.txt
    echo "RAM_TOTAL = $(free | grep 'Mem' | awk '{printf "%.3f GB", $2/(1024*1024)}')" >> save.txt
    echo "RAM_USED = $(free | grep 'Mem' | awk '{printf "%.3f GB", $3/(1024*1024)}')" >> save.txt
    echo "RAM_FREE = $(free | grep 'Mem' | awk '{printf "%.3f GB", $4/(1024*1024)}')" >> save.txt
    echo "SPACE_ROOT = $(df -BK | grep '/$' | awk '{printf "%.2f MB", $2 / 1024}')" >> save.txt
    echo "SPACE_ROOT_USED = $(df -BK | grep '/$' | awk '{printf "%.2f MB", $3 / 1024}')" >> save.txt
    echo "SPACE_ROOT_FREE="SPACE_ROOT_FREE = $(df -BK | grep '/$' | awk '{printf "%.2f MB", $4 / 1024}')"" >> save.txt
    
    cp save.txt $(date +"%d_%m_%g_%H_%M_%S").status
    echo -e "${BLUE}Done. We have saved the information for you!${NC}"
else
    echo -e "${BLUE}You canceled${NC}"
fi

rm save.txt

exit 0