#!/bin/bash

TARGET_IP=$1

for i in {1..1000}; do 
  curl -k -s https://$TARGET_IP > /dev/null; 
  echo "Process.."
done

echo "Done.."
