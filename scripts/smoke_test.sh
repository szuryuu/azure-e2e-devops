#!/bin/bash

TARGET_IP=$1
echo "checking if $TARGET_IP is alive"

for ((i = 0; i < 100; i++)); do
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://$TARGET_IP)

  if [[ "$HTTP_CODE" == "200" ]]; then
    echo "success"
    exit 0
  fi

  echo "waiting.. ($i/10)"
  sleep 5
done

echo "Failed.."
exit 1

