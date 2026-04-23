#!/bin/bash

set -u

ROOT_PATH="$PWD/cases/"
IFS=',' read -ra IDS <<<"${1:-}"

PROPERTY="Automation"
STATUS="Automated"
AUTHOR="Vol"

for id in "${IDS[@]+"${IDS[@]}"}"; do
    file=$(grep -rl "$id" "$ROOT_PATH")

    if [[ -z "$file" ]]; then
        echo "No file found for ID: $id"
        continue
    fi

    awk -v prop="$PROPERTY" -v status="$STATUS" -v author="$AUTHOR" '
        $0 ~ prop ".*=.*" { print prop " = \"" status "\""; print "Automated_by = \"" author "\""; next }
        { print }
    ' "$file" >"$file.tmp" && mv "$file.tmp" "$file"

done
