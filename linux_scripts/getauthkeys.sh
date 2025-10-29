#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script must be ran as root"
	exit 1
fi

echo -e '\n'
mapfile -t USERS < <(ls -A /home)

for user in "${USERS[@]}"; do
	path="/home/$user/.ssh/authorized_keys"

    echo "==================== authorized_keys file for $user ===================="
    if [[ ! -e "$path" ]]; then
        echo "File does not exist"
        echo -e '\n'
        continue
    elif [[ ! -s "$path" || $(<"$path") =~ ^[[:space:]]+$ ]]; then
        echo "File is empty"
        echo -e '\n'
        continue
    fi
    cat "$path"
    echo -e '\n'
done
