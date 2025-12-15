#!/bin/bash

cat <<END
    In this task you need to fix the script: ./game.sh accroding to Bash Style Guide.
    To test, what issues this script is having, use: shellcheck tool.

END

function display_menu () {
    cat <<END
        "PLAY: Hit 1 and enter."
        "HELP: Hit 2 and enter."
        "EXIT: Hit 3 and enter."

END
}

function display_help() {
  cat <<EOF
    INSTRUCTIONS:
    1. Choose a number between ${MIN_NUMBER} and ${MAX_NUMBER}
    2. Find your number's position in the shuffled array
    3. Enter the index within ${TIMEOUT_SECONDS} seconds
    4. Continue until you make a mistake or time runs out

EOF
}

readonly TIMEOUT_SECONDS=5
readonly MIN_NUMBER=0
readonly MAX_NUMBER=9
readonly ARRAY_SIZE=5

function start_game () {
    local chosen_number
    local player_score=0
    local game_active=1

    read -r -p "Enter number between ${MIN_NUMBER} and ${MAX_NUMBER}: " chosen_number

    if ! [[ "$chosen_number" =~ ^[0-9]$ ]]; then
        echo "Invalid input" >&2
        return 1;
    fi

    while [ "$game_active" -eq 1 ]; do
        local -a shuffled_array
        local -a index_array

        mapfile -t shuffled_array < <(shuf -i "${MIN_NUMBER}-${MAX_NUMBER}" -n "$ARRAY_SIZE")

        for (( i=1; i<=ARRAY_SIZE; i++)); do
            index_array[i]=$i
        done

        echo "Shuffeled array: ${shuffled_array[*]}"
        echo "Indices:         ${index_array[*]}"

        local user_index

        if ! read -t "$TIMEOUT_SECONDS" -r -p "Enter the index of your number: " user_index; then
            echo -e "\nTime's up!"
            game_active=0
            break
        fi

        if ! [[ "$user_index" =~ ^[0-9]+$ ]] || \
             [[ "$user_index" -lt 1 ]] || \
             [[ "$user_index" -gt "$ARRAY_SIZE" ]]; then

                echo "Invalid index" >&2;
                game_active=0
                break
            fi

        local shuffled_array_value="${shuffled_array[$((user_index-1))]}"
        if [[ "$shuffled_array_value" -eq "${chosen_number}" ]]; then
            echo "Great!"
            ((player_score++))
        else
            echo "Wrong! The number at index ${user_index} is ${shuffled_array_value}"
            game_active=0
        fi

        echo -e "\nGAME OVER"
        echo "You scored ${player_score} points"
    done
}


function main () {
  echo -e "\n NumberJack \n"
  
  local choice=0
  
  while [[ "${choice}" -ne 3 ]]; do
    display_menu
    
    if ! read -r -p "Enter your choice: " choice; then
      echo "Error reading input" >&2
      exit 1
    fi
    
    case "${choice}" in
      1)
        start_game
        ;;
      2)
        display_help
        ;;
      3)
        echo "Thanks for playing!"
        break
        ;;
      *)
        echo "Invalid choice. Please enter 1, 2, or 3." >&2
        ;;
    esac
  done
}

main "$@"