#!/bin/bash

# bersih-bersih terminal chef
clear_terminal(){
    clear
}

#fungsi speak to me
speak_to_me(){
    while true; do
    #ambil kata-kata motivasi dari API, ekstrak menggunakan regex 
affirmation=$(curl -s -H "Accept: application/json" "https://www.affirmations.dev" | sed -E 's/.*"affirmation":"([^"]*)".*/\1/') 
#memunculkan kata-kata kak gem
echo -n "Kata kak gem: "

#menampilkan kata per kata dengan efek seperti mengetik
for word in $affirmation; do
echo -n "$word " #print kata per kata
sleep 0.1
done

#jeda antar kalimat
echo ""
sleep 1
done
}

#fungsi on the run
on_the_run() {
    local width=$(tput cols)  #total langkah dari lebar terminal
    local bar_width=$((width - 20))  #lebar bar
    local progress=0  #inisialisasi progress
    local max=100

    echo -n "READY, SET, GO!"
    sleep 1
    echo ""

    while [ $progress -lt $max ]; do
    local filled=$((progress * bar_width / $max))  #hitung panjang bar yang terisi
    local empty=$((bar_width - filled))  #hitung panjang bar yang kosong
    printf "\r[%-${bar_width}s] %d%%" "$(printf '#%.0s' $(seq 1 $filled))" "$progress"  #print bar
 
sleep $(awk -v min=0.1 -v max=1 'BEGIN {srand(); print min+rand()*(max-min)}')  #random sleep antara 0.1 - 1 detik

progress=$((progress + (RANDOM % 5 + 1)))

    if [ $progress -ge $max ]; then
    progress=$max
    break 
    fi
done

printf "\r[%-${bar_width}s] 100%%" "$(printf '#%.0s' $(seq 1 $bar_width))"
echo -e "\nANDDD....YOU DID IT CHAMP!!! YOU BECOME A RUNNER!"
echo -e "\nDone!"
}

#fungsi Time
time_clock(){
    while true; do
    #ngambil tanggal dan waktu saat ini
    waktu_saiki=$(date +"%Y-%m-%d %H:%M:%S")
    
    printf "\r%s" "$waktu_saiki" #nampilin waktu ofc
    #sek...tunggu sedetik abis tu diperbarui
    sleep 1
done
}

#fungsi Money
money_that() {
    #tampilkan ASCII ART, gacor iki bismillah
    echo -e "\e[32m" #warna ascii art cyan

echo " ███▄ ▄███▓ ▄▄▄     ▄▄▄█████▓ ██▀███   ██▓▒██   ██▒";
echo "▓██▒▀█▀ ██▒▒████▄   ▓  ██▒ ▓▒▓██ ▒ ██▒▓██▒▒▒ █ █ ▒░";
echo "▓██    ▓██░▒██  ▀█▄ ▒ ▓██░ ▒░▓██ ░▄█ ▒▒██▒░░  █   ░";
echo "▒██    ▒██ ░██▄▄▄▄██░ ▓██▓ ░ ▒██▀▀█▄  ░██░ ░ █ █ ▒ ";
echo "▒██▒   ░██▒ ▓█   ▓██▒ ▒██▒ ░ ░██▓ ▒██▒░██░▒██▒ ▒██▒";
echo "░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒ ░░   ░ ▒▓ ░▒▓░░▓  ▒▒ ░ ░▓ ░";
echo "░  ░      ░  ▒   ▒▒ ░   ░      ░▒ ░ ▒░ ▒ ░░░   ░▒ ░";
echo "░      ░     ░   ▒    ░        ░░   ░  ▒ ░ ░    ░  ";
echo "       ░         ░  ░           ░      ░   ░    ░  ";
echo "                                                   ";
echo -e "\e[0m" #reset warna
    #tampilkan pesan awal
    echo "Morpheus: Halo Neo! pilih pil merah atau pil biru?"
    echo "1. Pil Merah"
    echo "2. Pil Biru"
    read -p "Pilihan Anda akan mempengaruhi keseluruhan hidup anda! (1/2): " choice

    # Ukuran terminal
    cols=$(tput cols) #lebar terminal
    lines=$(tput lines) #tinggi terminal
    clear

    # List simbol mata uang
    simbol=('$' '€' '£' '¥' '¢' '₹' '₩' '₿' '₣' '₳' 'Rp')
    delay=0.05  # Kecepatan animasi
    
    #warna using tput karena pake kode tidak berfungsi ya kawan
    green=$(tput setaf 2) #ini hijau
    gold=$(tput setaf 3) # ini emas/kuning
    reset=$(tput sgr0) #reset warna

    # Array untuk menyimpan posisi karakter (setiap baris sebagai string)
    declare -a matrix

    # Inisialisasi matrix dengan spasi
    for ((i = 0; i < lines; i++)); do
        matrix[$i]=$(printf "%${cols}s" " ")
    done

    #tentukan warna berdasarkan pilihan hidup neon
    if [[ "$choice" == "1" ]]; then
    #warna merah & oranye
    warna1=$(tput setaf 1) #ini merah
    warna2=$(tput setaf 3) #ini oranye

    elif [[ "$choice" == "2" ]]; then
    #warna hijau & emas
    warna1=$(tput setaf 2) #ini hijau
    warna2=$(tput setaf 3) #ini emas/kuning

    else
    echo "Ditanya pil merah/biru dijawab apa....kesalahan berpikir."
    exit 1
    fi
    reset=$(tput sgr0) #reset warna
    
    while true; do
        # Geser karakter ke bawah
        for ((i = lines - 1; i > 0; i--)); do
            matrix[$i]="${matrix[$((i-1))]}"
        done

        # Bangun baris baru untuk bagian atas
        row=""
        for ((j = 0; j < cols; j++)); do
            if (( RANDOM % 10 == 0 )); then
                random_index=$(( RANDOM % ${#simbol[@]} ))
                if (( RANDOM % 2 == 0)); then
                row+="${warna1}${simbol[$random_index]}${reset}" #hijau
                else
                row+="${warna2}${simbol[$random_index]}${reset}" #emas
                fi
            else
                row+=" "
            fi
        done
        matrix[0]="$row"

        # Cetak matrix ke layar
        printf "\e[H"
        for ((i = 0; i < lines; i++)); do
            echo -n "${matrix[$i]}"
            printf "\n"
        done

        sleep "$delay"
    done
}

#fungsi brain dance
brain_damage() {

    #bersihkan terminal
    clear

    #tampilkan ASCII art
echo -e "\e[1;35m"

echo "      :::::::::  :::::::::      :::     ::::::::::: ::::    ::: :::::::::      :::     ::::    :::  ::::::::  :::::::::: ";
echo "     :+:    :+: :+:    :+:   :+: :+:       :+:     :+:+:   :+: :+:    :+:   :+: :+:   :+:+:   :+: :+:    :+: :+:         ";
echo "    +:+    +:+ +:+    +:+  +:+   +:+      +:+     :+:+:+  +:+ +:+    +:+  +:+   +:+  :+:+:+  +:+ +:+        +:+          ";
echo "   +#++:++#+  +#++:++#:  +#++:++#++:     +#+     +#+ +:+ +#+ +#+    +:+ +#++:++#++: +#+ +:+ +#+ +#+        +#++:++#      ";
echo "  +#+    +#+ +#+    +#+ +#+     +#+     +#+     +#+  +#+#+# +#+    +#+ +#+     +#+ +#+  +#+#+# +#+        +#+            ";
echo " #+#    #+# #+#    #+# #+#     #+#     #+#     #+#   #+#+# #+#    #+# #+#     #+# #+#   #+#+# #+#    #+# #+#             ";
echo "#########  ###    ### ###     ### ########### ###    #### #########  ###     ### ###    ####  ########  ##########       ";

echo -e "\e[0m"

    #tampilkan pesan awal
    echo "Brain Damage: Task Manager di Terminal, katanya"
    echo
    
    #loop untuk nampilin proses detik demi detik, bata demi bata
    while true; do
    #simpan posisi kursor setelah ASCII art dan pesan awal
    tput cup 10 0

    #ambil waktu right now
    waktu_ini=$(date +"%T")

    #ambil informasi memori
    memory_info=$(free -m | awk 'NR==2 {printf "Memory used: %s/%s MB (%.2f%%)", $3, $2, ($3/$2)*100}')

    #ambil informasi jumlah file yg dibuka oleh prosesnya
    open_files=$(lsof | wc -l)

    #jumlah proses yang berjalan dibelakang layar (bg)
    bg_process=$(ps -e -o stat= | grep -c 'S')

    #ambil informasi penggunaan CPU
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

    #tampilkan informasi sistem
    echo -e "\e[1;34mTime Current: $waktu_ini\e[0m"
    echo -e "\e[1;34m$memory_info\e[0m"
    echo -e "\e[1;34mFile Opened: $open_files\e[0m"
    echo -e "\e[1;34mBackground Processes: $bg_process\e[0m"
    echo -e "\e[1;34mCPU Usage: $cpu_usage\e[0m"
    echo
 
    #ambil data pake ps bukan playstation, yg dibawah ini bewarna
    echo -e "\e[1;36mPID\tUSER\tCPU%\tMEM%\tTIME+\tCOMMAND\e[0m"
    ps aux --sort=-%cpu | awk 'NR<=11 {

    #warna untuk kolom tertentu coy
    pid_color="\033[1;31m" #ini merah o
    user_color="\033[1;32m" #ini hijau o
    cpu_color="\033[1;33m" #ini kuning o
    mem_color="\033[1;34m" #ini biru o
    time_color="\033[1;35m" #ini magenta o
    reset_color="\033[0m" #ini reset o

    #format output
    printf "%s%-6s%s\t%s%-8s%s\t%s%-6s%s\t%s%-6s%s\t%s%-8s%s\t%s\n",
    pid_color, $2, reset_color,
    user_color, $1, reset_color,
    cpu_color, $3, reset_color,
    mem_color, $4, reset_color,
    time_color, $10, reset_color,
    $11 #COMMAND
    }'

echo -e "\n\e[1;33mMaafkan saya karena CPU%-nya malah kegeser, tapi berfungsilah ya ps auxnya :)\e[0m"

#hapus posisi kursor hingga akhir layar
tput ed

#tunggu 1 detik sebelum data diperbarui
sleep 1

#bersihkan layar untuk tampilin real-time
done
}

#fungsi eclipse, this is just dark side of the moon ASCII art
eclipse(){
echo -e "\e[31m                                      '\$&\e[0m"
    echo -e "\e[32m                                      @R\$k\e[0m"
    echo -e "\e[33m                                    '\$!!!M&\e[0m"
    echo -e "\e[34m                                    @?~~~!\$k\e[0m"
    echo -e "\e[35m                                  '9!!~ ~~!MX\e[0m"
    echo -e "\e[36m                                  @X~~   \`~!\$k\e[0m"
    echo -e "\e[91m                                 9!!      ~~!\$X\e[0m"
    echo -e "\e[92m                                dR!~       \`~!\$>\e[0m"
    echo -e "\e[93m                               XR!~         \`~!\$k:\e[0m"
    echo -e "\e[94m                              tR!~        ::~~!!MMXXHHHH!!<:.\e[0m"
    echo -e "\e[95m                             <\$!xxiXX!!!~~~~~~~!!MMMMMMMMMMMMMMMXXXXx::\e[0m"
    echo -e "\e[96m                        .:X@N\$\$\$RMMX!!!!~~~~~~~~!!MMMM@@MMMMMMMMMMMMXMSMMtHHHX!\e[0m"
    echo -e "\e[31m                  :xiM#\"~  <\$!~  \`~~~!~~~~~~~~~~~!!MX!!!!!??#RR888MMMMMMMMMMMHH\e[0m"
    echo -e "\e[32m           ..XH@!~\`       X\$!~                 '~~~!MX!!!!!!!!!!!!?MMR@@\$MMMMMM\e[0m"
    echo -e "\e[33m     :xiM#\"~             <\$!~                     '~!MM??MMX!!!!!!!!!!!!!!??#R\$\e[0m"
    echo -e "\e[34mXH@M!\`\`                 :\$!!                        ~!R:   \`~!MM!XH!!!!!!!!!!!!\e[0m"
    echo -e "\e[35m                       <\$!~                         \`!!M:        \`~\"??HHX!!!!!!\e[0m"
    echo -e "\e[36m                      :\$!~                           \`!!R:              \`!!MMMH\e[0m"
    echo -e "\e[91m                     '\$!~                             \`~!8:                   ~\e[0m"
    echo -e "\e[92m                    :\$!!                               ~!!N:\e[0m"
    echo -e "\e[93m                   '\$!~                                 \`!!N:\e[0m"
    echo -e "\e[94m                  .\$!!~                                  ~~!&>\e[0m"
    echo -e "\e[95m                 '@!!~                                    ~!MN\e[0m"
    echo -e "\e[96m                .\$!!~                                     ~~!M&>\e[0m"
    echo -e "\e[31m               :@\$MHHHHHHHHH!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!H\$N\e[0m"

#fungsi untuk menambahkan warna
colorize() {
    local color_code=$1
    local text=$2
    echo -e "\e[${color_code}m${text}\e[0m"
}

#warna ANSI
RED="31"
GREEN="32"
YELLOW="33"
BLUE="34"
MAGENTA="35"
CYAN="36"
WHITE="37"

#menampilkan teks ASCII dengan warna
echo "                                                                                      "
colorize $RED "     ##                              /                                ##              "
colorize $GREEN "      ##                           #/                      #           ##             "
colorize $YELLOW "      ##                           ##                     ###          ##             "
colorize $BLUE "      ##                           ##                      #           ##             "
colorize $MAGENTA "      ##                           ##                                  ##             "
colorize $CYAN "  ### ##      /###    ###  /###    ##  /##       /###    ###       ### ##      /##    "
colorize $RED " #########   / ###  /  ###/ #### / ## / ###     / #### /  ###     #########   / ###   "
colorize $GREEN "##   ####   /   ###/    ##   ###/  ##/   /     ##  ###/    ##    ##   ####   /   ###  "
colorize $YELLOW "##    ##   ##    ##     ##         ##   /     ####         ##    ##    ##   ##    ### "
colorize $BLUE "##    ##   ##    ##     ##         ##  /        ###        ##    ##    ##   ########  "
colorize $MAGENTA "##    ##   ##    ##     ##         ## ##          ###      ##    ##    ##   #######   "
colorize $CYAN "##    ##   ##    ##     ##         ######           ###    ##    ##    ##   ##        "
colorize $RED "##    /#   ##    /#     ##         ##  ###     /###  ##    ##    ##    /#   ####    / "
colorize $GREEN " ####/      ####/ ##    ###        ##   ### / / #### /     ### /  ####/      ######/  "
colorize $YELLOW "  ###        ###   ##    ###        ##   ##/     ###/       ##/    ###        #####   "
colorize $BLUE "              /##                                                                     "
colorize $MAGENTA "            #/ ###                                                                    "
colorize $CYAN "           ##   ###                                                                   "
colorize $RED "           ##                                                                         "
colorize $GREEN "           ##                                                                         "
colorize $YELLOW "   /###    ######                                                                     "
colorize $BLUE "  / ###  / #####                                                                      "
colorize $MAGENTA " /   ###/  ##                                                                         "
colorize $CYAN "##    ##   ##                                                                         "
colorize $RED "##    ##   ##                                                                         "
colorize $GREEN "##    ##   ##                                                                         "
colorize $YELLOW "##    ##   ##                                                                         "
colorize $BLUE " ######    ##                                                                         "
colorize $MAGENTA "  ####      ##                                                                        "
colorize $CYAN "            /                                                                         "
colorize $RED "          #/                                                                          "
colorize $GREEN "    #     ##                                                                          "
colorize $YELLOW "   ##     ##                                                                          "
colorize $BLUE "   ##     ##                                                                          "
colorize $MAGENTA " ######## ##  /##      /##                                                            "
colorize $CYAN "########  ## / ###    / ###                                                           "
colorize $RED "   ##     ##/   ###  /   ###                                                          "
colorize $GREEN "   ##     ##     ## ##    ###                                                         "
colorize $YELLOW "   ##     ##     ## ########                                                          "
colorize $BLUE "   ##     ##     ## #######                                                           "
colorize $MAGENTA "   ##     ##     ## ##                                                                "
colorize $CYAN "   ##     ##     ## ####    /                                                         "
colorize $RED "   ##     ##     ##  ######/                                                          "
colorize $GREEN "    ##     ##    ##   #####                                                           "
colorize $YELLOW "                 /                                                                    "
colorize $BLUE "### /### /###   /   /###       /###    ###  /###                                      "
colorize $MAGENTA " ##/ ###/ /##  /   / ###  /   / ###  /  ###/ #### /                                   "
colorize $CYAN "  ##  ###/ ###/   /   ###/   /   ###/    ##   ###/                                    "
colorize $RED "  ##   ##   ##   ##    ##   ##    ##     ##    ##                                     "
colorize $GREEN "  ##   ##   ##   ##    ##   ##    ##     ##    ##                                     "
colorize $YELLOW "  ##   ##   ##   ##    ##   ##    ##     ##    ##                                     "
colorize $BLUE "  ##   ##   ##   ##    ##   ##    ##     ##    ##                                     "
colorize $MAGENTA "  ##   ##   ##   ##    ##   ##    ##     ##    ##                                     "
colorize $CYAN "  ###  ###  ###   ######     ######      ###   ###                                    "
colorize $RED "   ###  ###  ###   ####       ####        ###   ###                                   "
echo "                                                                                      "
echo "                                                                                      "
echo "                                                                                      "
echo "                                                                                      "

}


#fungsi main
main(){
    clear_terminal
    case $1 in 
    --play=Speak\ to\ Me)
    speak_to_me
    ;;
    --play=On\ the\ Run)
    on_the_run
    ;;
    --play=Time)
    time_clock
    ;;
    --play=Money)
    money_that
    ;;
    --play=Brain\ Damage)
    brain_damage
    ;;
    --play=Eclipse)
    eclipse
    ;;
    *)
    echo "Usage: ./dsotm.sh --play=<Track>"
    echo "Available Tracks: Speak to Me, On the Run, Time, Money, Brain Damage, Eclipse"
    ;;
    esac
}

main "$@"
