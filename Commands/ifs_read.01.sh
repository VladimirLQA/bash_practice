#!/bin/bash

set -ue

IFS=';' read -ra IDS <<< "${1:-}"
COUNT=0

for id in "${IDS[@]}"; do
    ((COUNT += 1))
    echo "$COUNT <<< iteration with argument >>>> $id"
done