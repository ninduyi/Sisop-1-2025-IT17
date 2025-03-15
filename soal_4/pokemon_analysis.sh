#!/bin/bash

FILE=$1
COMMAND=$2
OPTION=$3

# Fungsi Untuk Menampilkan Bantuan
function bantuan_menu() {
    echo "-----------------------------------------------------------------"
    echo " |      \|        \                     _/  \  |         \ "
    echo " \$$$$$$ \$$$$$$$$                    |   $$   \$$$$$$$$ "
    echo "  | $$     | $$          ______        \$$$$      /  $$ "
    echo "  | $$     | $$         |      \        | $$     /  $$ "
    echo "  | $$     | $$          \$$$$$$        | $$    /  $$ "
    echo " _| $$_    | $$                        _| $$_  /  $$"
    echo "|   $$ \   | $$                       |   $$ \|  $$"
    echo " \$$$$$$    \$$                        \$$$$$$| \$$"
    echo "-----------------------------------------------------------------"
    echo "Cara penggunaan : ./pokemon_analysis.sh <namafile> [opsi]"
    echo "opsi:"
    echo "   -h, --help              Menampilkan display ini"
    echo "   -i, --info              Menampilkan pokemon dengan Usage dan RawUsage tertinggi"
    echo "   -s, --sort <metode>     Menyortir data sesuai metode nya"
    echo "                           Metode = Pokemon, Usage%, RawUsage, HP, Atk, Def, SpAtk, SpDef, Speed"
    echo "   -g, --grep <nama>       Menampilkan info nama pokemon"
    echo "   -f, --filter <tipe>     Menampilkan pokemon yang memiliki tipe tertentu"
    exit 0
}

# Menampilkan Usage & RawUsage Terbesar

function summary() {
        echo "Summary of $FILE"
    	tail -n +2 "$FILE" | sort -t',' -k2,2nr | awk -F',' 'NR==1 {print "Highest Adjusted Usage: "$1","$2}'
    	tail -n +2 "$FILE" | sort -t',' -k3,3nr | awk -F',' 'NR==1 {print "Highest Raw Usage:      "$1","$3}'

        exit 0
}



# Mengurutkan data

function mengurutkan_data {
        HEADER=$(head -1 "$FILE")
        echo "$HEADER"
        if [ "$OPTION" = "pokemon" ]; then
            tail -n +2 "$FILE" | sort -t, -k1,1
        else
            tail -n +2 "$FILE" | sort -t, -k$(awk -F, -v col="$OPTION" '{for (i=1; i<=NF; i++) if ($i == col) print i}' <<< "$HEADER") -nr
   fi
        exit 0
}



# Cari Pokemon berdasarkan nama
function cari_pokemon() {

 [ -z "$OPTION" ] && { echo "Error: Nama Pokémon harus diberikan!"; exit 1; }
    
    head -1 "$FILE"  
    tail -n +2 "$FILE" | grep -i "$OPTION"

    exit 0
}




# Filter Pokémon berdasarkan Type

function filter_type() {
    HEADER=$(head -1 "$FILE")
    echo "$HEADER"
    tail -n +2 "$FILE" | grep -i "$OPTION" | sort -t, -k2 -nr
}




case "$COMMAND" in
    -h|--help) bantuan_menu;;
    -i|--info) summary ;;
    -s|--sort) mengurutkan_data ;;
    -g|--grep) cari_pokemon ;;
    -f|--filter)filter_type ;;
    *)
        echo "Error: Perintah '$COMMAND' tidak dikenali!"
 	echo "gunakan -h or --help untuk info lebih lanjut"
        exit 1
        ;;


esac

