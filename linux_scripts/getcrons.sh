#!/bin/bash
shells=()
noninteractiveUsers=()
while IFS= read -r line; do
	[[ $line =~ ^# ]] && continue
	shells+=("$line")
done < /etc/shells

while IFS= read -r line; do
	user=$(cut -d : -f1 <<< "$line")
	shell=$(cut -d : -f7 <<< "$line")
	if [[ $(basename "$shell") == "nologin" || $(basename "$shell") == "false" || ! " ${shells[*]} " =~ "$shell" ]]; then
		noninteractiveUsers+=("$user")
		continue
	fi
	echo "==================== Crontab for $user ===================="
	sudo -u "$user" crontab -l
done < /etc/passwd

echo -e "\nThe following users have non-interactive shells and should be in the /etc/cron.deny list:"
echo ${noninteractiveUsers[@]}

