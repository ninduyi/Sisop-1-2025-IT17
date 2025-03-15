#!/bin/bash

current_dir=$(pwd)

file_player="$current_dir/data/player.csv"
log_dir="$current_dir/logs"

while true; do
    clear

    echo "====================================================="
    echo "                  ARCAEA TERMINAL                    "
    echo "====================================================="
    echo " [1] Add CPU - Core Monitor to Crontab 🖥️          "
    echo " [2] Add RAM - Fragment Monitor to Crontab 💾      "
    echo " [3] Remove CPU - Core Monitor from Crontab ❌     "
    echo " [4] Remove RAM - Fragment Monitor from Crontab ❌ "
    echo " [5] View All Scheduled Monitoring Jobs 📅         "
    echo " [6] Exit ARCAEA Terminal 🚪                       "
    echo "====================================================="
    echo ""
    read -p "Please select an option [1-6]: " option

    case $option in
        1)
            if ! crontab -l | grep -q "$current_dir/scripts/core_monitor.sh"; then
                (crontab -l; echo "* * * * * /bin/bash $current_dir/scripts/core_monitor.sh >> $log_dir/core.log 2>&1") | crontab -
                echo "✅ CPU - Core Monitor successfully added to crontab!"
            else
                echo "⚠️ CPU - Core Monitor is already present in crontab."
            fi
            ;;
        2)
            if ! crontab -l | grep -q "$current_dir/scripts/frag_monitor.sh"; then
                (crontab -l; echo "* * * * * /bin/bash $current_dir/scripts/frag_monitor.sh >> $log_dir/fragment.log 2>&1") | crontab -
                echo "✅ RAM - Fragment Monitor successfully added to crontab!"
            else
                echo "⚠️ RAM - Fragment Monitor is already present in crontab."
            fi
            ;;
        3)
            crontab -l | grep -v "$current_dir/scripts/core_monitor.sh" | crontab -
            echo "✅ CPU - Core Monitor successfully removed from crontab!"
            ;;
        4)
            crontab -l | grep -v "$current_dir/scripts/frag_monitor.sh" | crontab -
            echo "✅ RAM - Fragment Monitor successfully removed from crontab!"
            ;;
        5)
            echo "📋 Current scheduled jobs in crontab:"
            crontab -l
            ;;
        6)
            echo "🚪 Exiting ARCAEA Terminal. See you next time!"
            exit 0
            ;;
        *)
            echo "❌ Invalid choice! Please select a valid option [1-6]."
            ;;
    esac

    echo ""
    read -p "Press Enter to continue... ⏳"
done
