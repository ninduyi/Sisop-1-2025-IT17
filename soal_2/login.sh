#!/bin/bash

file_player="data/player.csv"

while true; do
    echo "Enter your email: "
    read -r email

    if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo -e "\n⛔ Invalid email format. Please enter a valid email. ⛔"
        continue 
    elif ! grep -q "^$email," "$file_player"; then
        echo -e "\n⛔ Email not found. Please enter a valid email. ⛔"
        continue
    else
        while true; do
            echo "Enter your password: "
            read -rs pass

            hashed_pass=$(echo -n "RAMADHAN/$pass/ceriaYH17" | sha256sum | awk '{print $1}')
            
            if grep -q "^$email,[^,]*,$hashed_pass" "$file_player"; then
                echo -e "\nLogin successful! 🎉\n"
                ./scripts/manager.sh # ini buat klo berhasil login trs masuk opsi manager
                break 2  
            else
                echo -e "\n❌ Incorrect password. Please try again. ⚠️"
            fi
        done
    fi

    echo -e "⚠️ Please try again.\n" 
done


