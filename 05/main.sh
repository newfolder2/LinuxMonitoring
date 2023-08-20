#!/bin/bash
start_script=$(date +%s)
path=$1
NC='\033[0m'
RED='\033[41m'
GREEN='\033[32m'
if [ $# != 1 ]
then
    echo -e "${RED}Error:${NC} not enough arguments"
elif [ ${1: -1} != "/" ]
then
    echo -e "${RED}Error:${NC} wrong path"
else
    all_folders=$(find $path -type d | wc -l)
    top_5_folders=$(du -Sh $path | sort -rh | head -5 | cat -n | awk '{print $1" - "$3", "$2}')
    number_of_files=$(find $path -type f| wc -l)
    number_of_conf_files=$(find $pat -type f -name "*.conf" | wc -l)
    number_of_txt_files=$(find $pat -type f -name "*.txt" | wc -l)
    number_of_executable_files=$(find $pat -type f -executable -exec du -h {} + | wc | awk '{ print $1 }')
    number_of_log_files=$(find $pat -type f -name "*.log" | wc -l)
    number_of_archive=$(find $pat -regex '.*\(tar\|zip\|gz\|rar\)' | wc -l )
    number_of_symbolic_links=$(find $pat -type l | wc -l)
    extension=$(find $path -type f -exec du -Sh {} + | sort -rh | head -n 10 | awk -F '.' 'length($NF)<14 {print $NF}')
    top_10_big_files=$(find $path -type f -exec du -Sh {} + | sort -rh | head -n 10 | awk '{printf "%d - %s, %s,\n",NR, $2, $1}')
    exefile=$(find $path -type f -perm -u+rx -exec du -Sh {} + | sort -rh | head -n 10 | awk '{print $2}')
    if [[ $exefile == "" ]]
    then
        hash=0;
    else
        hash=$(sudo md5sum $exefile | awk '{print $1}')
    fi
    top_10_exe_files=$(sudo find $path -type f -executable -exec du -Sh {} + | sort -rh | head -n 10 | awk '{printf "%d - %s, %s,\n",NR, $2, $1}')
    lines=$(sudo find $path -type f -executable -exec du -Sh {} + | sort -rh | head -n 10 | awk '{printf "%d - %s, %s,\n",NR, $2, $1}' | wc -l)
    echo -e "${GREEN}Total number of folders (including all nested ones) = $all_folders"
    echo -e "TOP 5 folders of maximum size arranged in descending order (path and size):"
    echo "$top_5_folders"
    echo "Total number of files = $number_of_files"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $number_of_conf_files"
    echo "Text files = $number_of_txt_files"
    echo "Executable files = $number_of_executable_files"
    echo "Log files (with the extension .log) = $number_of_log_files"
    echo "Archive files = $number_of_archive"
    echo "Symbolic links = $number_of_symbolic_links"
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    paste -d' ' <(echo "$top_10_big_files") <(echo "$extension")
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
    if [ $lines -eq 10 ]
    then
        paste -d' ' <(echo "$top_10_exe_files") <(echo "$hash")
    else
        echo "etc up to 10"
    fi
    end_script=$(date +%s)
    script_runtime=$((end_script - start_script))
    echo "Script execution time (in seconds) = $script_runtime"
fi