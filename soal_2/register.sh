#!/bin/bash

file_player="data/player.csv"

while true; do
    echo "Enter your email: "
    read -r email

    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        if grep -q "^$email," "$file_player"; then
            echo "This email is already registered. Please use a different email. ❌"
        else
            break  
        fi
    else
        echo "Invalid email format. Please make sure the email contains '@' and '.'. ❌"
    fi
done

echo "Enter your username: "
read -r username

while true; do
    echo "Enter your password (min 8 characters, 1 uppercase letter, 1 lowercase letter, and 1 number):"
    read -rs pass

    if [[ ${#pass} -ge 8 && "$pass" == *[[:lower:]]* && "$pass" == *[[:upper:]]* && "$pass" == *[0-9]* ]]; then
        break
    else
        echo "Password does not meet the requirements. Please try again. ❌"
    fi
done

hashed_pass=$(echo -n "RAMADHAN/$pass/ceriaYH17" | sha256sum | awk '{print $1}')

echo "$email,$username,$hashed_pass" >> "$file_player"
echo ""
echo "Registration successful! 🎉"
