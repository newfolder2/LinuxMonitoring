#!/bin/bash
source "$(dirname "$0")/defcolors.conf"
BG1=$column1_background
txt1=$column1_font_color
BG2=$column2_background
txt2=$column2_font_color
check=0
regex='^[1-6]+$'
NC='\033[0m'
text_colors=("" "\033[97m" "\033[91m" "\033[92m" "\033[96m" "\033[95m" "\033[30m")
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
parametrs=16

for digit in "$BG1" "$txt1" "$BG2" "$txt2";
    do
        if ! [[ "$digit" =~ $regex ]] || [ "$digit" -eq 0 ]
        then
            check=1
        fi
done

if [ $BG1 -eq $txt1 ] || [ $BG2 -eq $txt2 ]
then
    echo "Colors is same"
    check=1
fi

for ((i = 0; i < parametrs; i++))
do
    if [ $check -eq 0 ]
    then
        echo -e "${background_colors[$BG1]}${text_colors[$txt1]}${name[$i]}${NC} = ${background_colors[$BG2]}${text_colors[$txt2]}${info[$i]}${NC}"
    else
        echo -e "${background_colors[2]}${text_colors[3]}${name[$i]}${NC} = ${background_colors[4]}${text_colors[5]}${info[$i]}${NC}"
    fi
done

colors=("" "white" "red" "green" "blue" "purple" "black")

   if [ $check -eq 1  ]
   then 
        echo ""
        echo "Column 1 background = default (red)"
        echo "Column 1 font color = default (green)"
        echo "Column 2 background = default (blue)"
        echo "Column 2 font color = default (purple)"
    else 
        echo ""
        echo "Column 1 background = $BG1 (${colors[$BG1]})"
        echo "Column 1 font color = $txt1 (${colors[$txt1]})"
        echo "Column 2 background = $BG2 (${colors[$BG2]})"
        echo "Column 2 font color = $txt2 (${colors[$txt2]})"
     fi   