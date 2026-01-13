#!/bin/bash

IP=$(terraform -chdir=terraform output -raw vm_pub_ip)

ssh -i ~/.ssh/botika_nopass adminuser@$IP
