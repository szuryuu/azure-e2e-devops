#!/bin/bash

TARGET_IP=$1
echo "checking if $TARGET_IP is alive"

for ((i = 0; i < 100; i++)); do
  HTTP_CODE=$(curl -k -s -o /dev/null -w "%{http_code}" https://$TARGET_IP)

  if [[ "$HTTP_CODE" == "200" ]]; then
    echo "success"
    exit 0
  fi

  echo "waiting.. ($i/99)"
  sleep 5
done

echo "Failed.."
exit 1

