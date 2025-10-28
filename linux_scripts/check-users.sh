#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[36m"
RESET="\e[0m"
BOLD="\e[1m"


echo -e "$BLUE[i] Fetching list of valid users$RESET"
IFS= read -r -d '' -a VALID_USERS <<< "$(curl -sL https://raw.githubusercontent.com/LZX1000/IRSEC-2025/refs/heads/main/valid-linux-users.txt)"

# Store usernames, UIDs, and GIDs of every user in an array
mapfile -t userinfo < <(cut -d : -f1,3,4 /etc/passwd)

echo -e "$BLUE[i] Checking local users against list$RESET"

usernames=("${userinfo[@]%%:*}")

for user in "${usernames[@]}"; do
    if [[ ! " ${VALID_USERS[*]} " == *" $user "* ]]; then
        echo -e "$RED[!] $user is not a valid user$RESET"
    fi
done

echo -e "$GREEN[*] Done!$RESET"

