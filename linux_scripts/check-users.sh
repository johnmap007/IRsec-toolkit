#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[36m"
RESET="\e[0m"


echo -e "$BLUE[i] Fetching list of valid users...$RESET"
IFS= read -r -d '' -a USERS <<< "$(curl -sL https://raw.githubusercontent.com/LZX1000/IRSEC-2025/refs/heads/main/valid-linux-users.txt)"

echo -e "$BLUE[i] Checking local users against list$RESET"
while IFS= read -r user; do
    if [[ ! " ${USERS[*]} " == *" $user "* ]]; then
        echo -e "$RED[!] $user IS NOT A VALID USER!!!$RESET"
    fi
done < <(cut -d : -f1 /etc/passwd)

echo -e "$GREEN[*] Done!$RESET"

