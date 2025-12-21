#!/bin/bash

set -euo pipefail

cat <<EOF
====================================================
Develop a pow() function that takes two arguments (a, b) and
raises the first argument to the power of the second (a^b).

Examples:
    - pow 2 3 > 8
    - pow 2 5 > 32

====================================================

EOF

function pow () {
    local number=$1
    local power=$2
    local result=1

    if ! [[ "$number" =~ ^[0-9]+$ ]] || ! [[ "$power" =~ ^[0-9]+$ ]]; then
        echo "Invalid input." >&2
        return 1
    fi

    if [[ $power -eq 0 ]]; then
        echo "1"
        return 0
    fi
    
    if [[ $number -eq 0 ]]; then
        echo "0"
        return 0
    fi

    local result=$((number ** power))
        echo "Result: $result"
    return 0
}

pow "$@"