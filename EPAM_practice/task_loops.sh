#!/bin/bash

set -e

cat <<EOF
====================================================
Task
Develop a script that takes a string as an argument and
returns its reverse version, changing uppercase letters
to lowercase and back
====================================================

EOF

reverse_swap_case () {
    local INPUT=$1
    local REVERSED=""
    local CASE_CHANGED=""

    if [[ -z $INPUT ]]; then
        echo "Empty string was passed"
        exit 1
    fi

    REVERSED=$(echo $INPUT | rev)

    for (( i=0; i<${#REVERSED}; i++)); do
        char="${REVERSED:$i:1}"

        if [[ "$char" =~ [A-Z] ]]; then
            CASE_CHANGED+=$(echo $char | awk '{print tolower($0)}')
        elif [[ "$char" =~ [a-z] ]]; then
            CASE_CHANGED+=$(echo $char | awk '{print toupper($0)}')
        else 
            CASE_CHANGED+=$char
        fi
    done

    echo "Test string:" $INPUT
    echo "Result:" $CASE_CHANGED
    echo "=============================================="
}


reverse_swap_case "Hello World"
reverse_swap_case "bash"
reverse_swap_case "EPAM"