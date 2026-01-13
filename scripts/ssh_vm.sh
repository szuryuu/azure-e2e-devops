#!/bin/bash

IP=$(terraform -chdir=terraform output -raw vm_pub_ip)

echo "Connecting to $IP"
ssh -i ~/.ssh/botika_nopass adminuser@"${IP}"
