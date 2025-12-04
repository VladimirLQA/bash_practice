#!/bin/bash

set -e

cat <<EOF
====================================================
Task
An unsorted list is passed to the script.
Write a program that will output the sum of even numbers
====================================================

EOF

function sum_even_numbers () {
    local readonly INPUT="$1"
    local sum=""

    if [ -z "$INPUT" ]; then
        sum=0
    else 
        IFS=',' read -r -a array <<< "$INPUT"
        for num in "${array[@]}"; do
            if (( num % 2 == 0 )); then
                sum=$(( sum+num ))
            fi
        done
    fi

    echo "Test list:" "$INPUT"
    echo "Result:" "$sum"
    echo "=============================================="
}

sum_even_numbers "1,2,3,4,5,6,7" # 12
sum_even_numbers "4,3,1"         # 4
sum_even_numbers "2,2,9,3,8"     # 12
sum_even_numbers ""              # 0