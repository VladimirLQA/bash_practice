#!/bin/bash

set -e

cat <<EOF
====================================================
Develop script that takes any string and calculate count of letters,
numbers, symbols '*!@#$%^&()_+' inside except whitespaces
====================================================

EOF

function check_string() {
    local readonly INPUT="$1"
    local STRING="$1"
    local STR_WITHOUT_WHITESPACES=${STRING// /} # replace all
    local numbers=0
    local letters=0
    local symbols=0
    # local pattern='\*!@#\$%\^&\(\)_\+' # didn't work for me
    local pattern='[*!@#$%^&()_+]'

    for (( i=0; i<${#STR_WITHOUT_WHITESPACES}; i++)); do 
        char="${STR_WITHOUT_WHITESPACES:i:1}"
        if [[ "$char" =~ [a-zA-Z] ]]; then
            ((letters+=1))
        elif [[ "$char" =~ [0-9] ]]; then
            ((numbers+=1))
        elif [[ "$char" =~ $pattern ]]; then
            ((symbols+=1))
        fi
    done

    echo "Test list:" "$INPUT"
    echo "Result: Numbers: $numbers Symbols: $symbols Letters: $letters"
    echo "=============================================="
}

check_string "Hello ! ** 564gfhf"   # Numbers: 3 Symbols: 3 Letters: 9
check_string "Hello !   +"          # Numbers: 0 Symbols: 2 Letters: 5
check_string "Hello !!"             # Numbers: 0 Symbols: 2 Letters: 5
