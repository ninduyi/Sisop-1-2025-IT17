#!/bin/bash

show_main_menu() {
    clear
    echo "=============================================================="
    echo "               🌟  Welcome to ARCAEA TERMINAL 🌟              "
    echo "============================================================== "
    echo "  [1] Register New Account        📝                          "
    echo "  [2] Login to Existing Account  🔑                           "
    echo "  [3] Exit Arcaea Terminal       🚪                           "
    echo "=============================================================="
    echo ""
    read -p "Enter option [1-3]: " opsi_terminal
}

while true; do
    show_main_menu

    case $opsi_terminal in
        1)
            echo "📝 Registering a New Account..."
            ./register.sh
            read -p "✅Registration successful! Press Enter to continue..."
            ;;
        2)
            echo "🔑 Logging into Existing Account..."
            ./login.sh
            ;;
        3)
            echo "🚪 Exiting Arcaea Terminal. Goodbye!"
            exit 0
            ;;
        *)
            echo "❌ Invalid option. Please choose a valid option [1-3]."
            ;;
    esac
done
