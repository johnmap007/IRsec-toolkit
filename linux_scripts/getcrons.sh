#!/bin/bash
shells=()
while IFS= read -r line; do
	[[ $line =~ ^# ]] && continue
	shells+=("$line")
done < /etc/shells

while IFS= read -r line; do
	user=$(cut -d : -f1 <<< "$line")
	shell=$(cut -d : -f7 <<< "$line")
	if [[ $(basename "$shell") == "nologin" || $(basename "$shell") == "false" || ! " ${shells[*]} " =~ "$shell" ]]; then
		continue
	fi
	echo "==================== Crontab for $user ===================="
	sudo -u "$user" crontab -l
done < /etc/passwd

