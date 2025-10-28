#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[36m"
YELLOW="\e[33m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "$BLUE[i] Fetching list of valid users$RESET"
mapfile -t VALID_USERS < <(curl -sL "https://raw.githubusercontent.com/LZX1000/IRSEC-2025/refs/heads/main/valid-linux-users.txt" | tr -d '\r' | sed '/^\s*$/d')
# Store usernames, UIDs, and GIDs of every user in an array
mapfile -t userinfo < <(cut -d : -f1,3,4 /etc/passwd)

echo -e "$BLUE[i] Checking local users against list$RESET"

usernames=("${userinfo[@]%%:*}")

for user in "${usernames[@]}"; do
    if [[ ! " ${VALID_USERS[*]} " == *" $user "* ]]; then
        echo -e "$YELLOW[?] $user is not on the list$RESET"
    fi
done
echo -e "\n"

for entry in "${userinfo[@]}"; do
    IFS=: read -r username uid gid <<< "$entry"
    if [[ ! "$username" == "root" && ("$uid" == 0 || "$gid" == 0) ]]; then
        echo -e "$BOLD$RED[!] $username HAS A UID OR GID OF 0!!!$RESET"
    fi
done

echo -e "$GREEN[*] Done!$RESET"

