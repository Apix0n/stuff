#!/bin/bash

# Made by Apix | @Apix0n
# https://apix0n.github.io/stuff

if [ -z "$1" ]
then
    clear
    echo '---- FolderSpam ----'
    echo 'How many folders should be created? (Type 0 for infinite folders)'
    echo 'Press Ctrl+C or Command+C to stop the creation of folders'
    read -p 'Value: ' stopnumber
else
    stopnumber="$1"
fi

# If the user chose infinite folders, the script will end at 2147483647 
# (integer limit for x32 systems)
if [[ "$stopnumber" == 0 ]]
then
    stopnumber='2147483647'
fi
number='0'

for ((i=1;i<=stopnumber;i++))
do
    number=$((number + 1))
    mkdir -p folder$number
done