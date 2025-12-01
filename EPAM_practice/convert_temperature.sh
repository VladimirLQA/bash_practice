#!/bin/bash

set -e

cat <<EOF
====================================================
Develop a script that takes the temperature value in Celsius OR Kelvins and returns the inverse value.
The formula is pretty simple: "C = K - 273`; `K = C + 273"
====================================================

EOF

function convert_temperature () {
    local readonly INPUT="$1"
    local INITIAL_TEMPERATURE="$1"
    local CONVERTED_TEMPERATURE=""
    local DIGITS="${INITIAL_TEMPERATURE//[^0-9]/}"
    local TEMPERATURE_TYPE="${INITIAL_TEMPERATURE//[^a-zA-Z]/}"
    local OFFSET=273

    if [[ "$TEMPERATURE_TYPE" =~ K ]]; then
        CONVERTED_TEMPERATURE="$(( DIGITS-OFFSET ))C"
    else
        CONVERTED_TEMPERATURE="$(( DIGITS+OFFSET ))K"
    fi

    echo "Test temperature:" "$INPUT"
    echo "Result:" "$CONVERTED_TEMPERATURE"
    echo "=============================================="
}

convert_temperature "55C"    # 328K
convert_temperature "122K"   # -151C
convert_temperature "98C"    # 371K
