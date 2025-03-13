#!/bin/bash

file_player="data/player.csv"

login() {
    echo "Enter your email: "
    read -r email

    if ! grep -q "^$email," "$file_player"; then
        echo -e "\nEmail not found. Please enter a valid email."
        return 1
    else
        echo "Enter your password: "
        read -rs pass

        hashed_pass=$(echo -n "RAMADHAN/$pass/ceriaYH17" | sha256sum | awk '{print $1}')

        if grep -q "^$email,$hashed_pass" "$file_player"; then
            echo -e "\nLogin successful!\n"
        else
            echo -e "\nIncorrect password. Please enter the correct password."
            return 1
        fi
    fi
}

while true; do
    if login; then
        break  
    else
        echo -e "\nPlease try again."
    fi
done
