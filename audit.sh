#!/bin/bash

systemctl enable auditd
curl -sL https://raw.githubusercontent.com/johnmap007/IRsec-toolkit/refs/heads/main/custom.rules
sudo cp custom.rules /etc/audit/rules.d/
augenrules --load
systemctl restart auditd
sudo sed -i '/<\/ossec_config>/i\<localfile>\n<location>\/var\/log\/audit\/audit.log<\/location>\n<log_format>audit<\/log_format>\n<\/localfile>' /var/ossec/etc/ossec.conf
