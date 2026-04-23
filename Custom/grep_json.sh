#!/bin/sh

set -e
# Json file content example
# {
#  "Username": {
#    "accountBalance": 5,
#    "accountId": "00000000",
#    "email": "dreamteam312@test.com",
#    "name": "UserName",
#    "password": "password"
#  },
# }

# find line > extract last quoted part > strip the double quotes
#
# `-o` - print only the matched part, not the whole line
grep -o '"accountId": *"[^"]*"' "$1" | grep -o '"[^"]*"$' | tr -d '"'
