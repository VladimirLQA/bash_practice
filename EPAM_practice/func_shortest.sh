#!/bin/bash

set -eo pipefail

cat <<EOF
===========================================================
Develop the shortest() function, which can take an unlimited number of arguments(strings) and
output the shortest argument.

Examples:
    shortest "Java" "Bash" "Python"
        Java
        Bash
===========================================================

EOF

function shortest () {
    local inputArray=("$@")
    local -a shortestStrs=()
    local shortest="${inputArray[0]}"

    if [[ "$#" -eq 0 ]]; then
        echo "Empty input"
        return 1
    fi 

    for word in "${inputArray[@]}"; do
        if [[ "${#word}" -lt "${#shortest}" ]]; then 
            shortest="$word"
            shortestStrs=("$word")
        elif [[ "${#word}" -eq "${#shortest}" ]]; then
            shortestStrs+=("$word")
        fi

    done

    for word in "${shortestStrs[@]}"; do
        echo "$word"
    done
}

shortest "$@"