#!/bin/bash

TARGET_IP=$1

for i in {1..1000}; do curl -s http://$TARGET_IP > /dev/null; done
