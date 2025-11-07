#!/bin/bash

systemctl enable auditd
curl -sL https://github.com/johnmap007/IRsec-toolkit/custom.rules
sudo cp custom.rules /etc/audit/rules.d/
augenrules --load
systemctl restart auditd
sudo sed -i '/<\/ossec_config>/i\<localfile>\n<location>\/var\/log\/audit\/audit.log<\/location>\n<log_format>audit<\/log_format>\n<\/localfile>' /var/ossec/etc/ossec.conf
