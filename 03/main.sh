#!/bin/bash

NC='\033[0m'
text_colors=("" "\033[97m" "\033[91m" "\033[92m" "\033[94m" "\033[95m" "\033[30m")
background_colors=("" "\033[107m" "\033[101m" "\033[102m" "\033[104m" "\033[105m" "\033[40m")
name=("HOSTNAME" "TIMEZONE" "USER" "OS" "DATE" "UPTIME" "UPTIME_SEC" "IP" "MASK" "GATEWAY" "RAM_TOTAL" "RAM_USED" "RAM_FREE" "SPACE_ROOT" "SPACE_ROOT_USED" "SPACE_ROOT_FREE")
info=(
    "$(hostname)"
    "$(cat /etc/timezone) \"UTC\" $(date +"%Z")"
    "$(whoami)"
    "$(hostnamectl | grep 'Operating System' | awk '{print $3"  "$4" "$5}')"
    "$(date +%"d %B %Y %T")"
    "$(uptime -p)"
    "$(cat /proc/uptime | awk '{print $1}')"
    "$(hostname -I | awk '{print $1}')"
    "$(ifconfig | grep $(hostname -I | awk '{print $1}') | awk '{print $4}')"
    "$(ip route | grep default | awk '{print $3}')"
    "$(free | grep 'Mem' | awk '{printf "%.3f GB", $2/(1024*1024)}')"
    "$(free | grep 'Mem' | awk '{printf "%.3f GB", $3/(1024*1024)}')"
    "$(free | grep 'Mem' | awk '{printf "%.3f GB", $4/(1024*1024)}')"
    "$(df -BK | grep '/$' | awk '{printf "%.2f MB", $2 / 1024}')"
    "$(df -BK | grep '/$' | awk '{printf "%.2f MB", $3 / 1024}')"
    "$(df -BK | grep '/$' | awk '{printf "%.2f MB", $4 / 1024}')"
)
number_of_colors=4
regex='^[1-6]+$'

if [ "$#" -ne $number_of_colors ]
    then
        echo -e "${background_colors[6]}${text_colors[5]}Wrong number of colors${NC}"
        exit
fi
if [ $1 -eq $2 ] || [ $3 -eq $4 ]
    then
        echo -e "${background_colors[6]}${text_colors[5]}You chose same colors. You can try again :)${NC}"
        read -r -p "Do you wanna try again? Y/N: " yep
        if [[ $yep = "Y"  || $yep = "y" ]]
        then
            read -r -p "Please choose colors: 1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black: " answer
            source "$(dirname "$0")/main.sh" $answer
        fi
        exit
fi
for color in "$1" "$2" "$3" "$4"
do
    if ! [[ "$color" =~ "$regex" ]]
        then
            echo -e "${background_colors[6]}${text_colors[5]}Sorry, we haven't this color. Please enter digit in range from 1 to 6.${NC}"
        exit
    fi
done

parametrs=16
for ((i = 0; i < parametrs; i++))
do
    echo -e "${background_colors[$1]}${text_colors[$2]}${name[$i]}${NC} = ${background_colors[$3]}${text_colors[$4]}${info[$i]}${NC}"
done