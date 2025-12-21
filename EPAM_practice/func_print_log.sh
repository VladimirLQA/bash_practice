#!/bin/bash

set -eo pipefail

cat <<EOF
===========================================================
Develop a print_log() function that takes a string as an argument and outputs the
same string with the date at the beginning.
In order for the automatic check to work, the string must be in this format: YEAR-MONTH-DAY HOUR:MINUTES

Examples:
    print_log "Hello World!"
        [2022-05-10 13:04] Hello World!

===========================================================

EOF

function print_log () {
    local input="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M')

    echo "[$timestamp] $input"
}

print_log "$@"