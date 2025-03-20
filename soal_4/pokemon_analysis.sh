#!/bin/bash

FILE=$1
COMMAND=$2
OPTION=$3

# Cek argumen
if [ $# -lt 2 ]; then
    echo "Error: Kurang argumen."
    echo "Gunakan -h atau --help untuk bantuan."
    exit 1
fi

# Cek file
if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' tidak ditemukan!"
    exit 1
fi

# Fungsi Bantuan
function bantuan_menu() {
    echo "============================================================================================================================"
    echo " _|_|_|   _|_|_|_|_|                          _|   _|_|_|_|_|         _|_|_|     _|_|       _|_|_|     _|_|     _|_|_|    "
    echo "   _|         _|                            _|_|           _|       _|         _|    _|   _|         _|    _|   _|    _|  "
    echo "   _|         _|           _|_|_|_|_|         _|         _|         _|  _|_|   _|_|_|_|   _|         _|    _|   _|_|_|    "
    echo "   _|         _|                              _|       _|           _|    _|   _|    _|   _|         _|    _|   _|    _|  "
    echo " _|_|_|       _|                              _|     _|               _|_|_|   _|    _|     _|_|_|     _|_|     _|    _|  "
    echo "============================================================================================================================"
    echo "    ▌-----------------------------------------------------▐"
    echo "    ▌ Cara penggunaan: ./pokemon_analysis.sh <file> <opsi>▐"
    echo "    ▌ Opsi:                                               ▐"
    echo "    ▌   -h, --help            Tampilkan bantuan           ▐"
    echo "    ▌   -i, --info            Tampilkan Usage tertinggi   ▐"
    echo "    ▌   -s, --sort <metode>   Urutkan data descending     ▐"
    echo "    ▌       Metode: name, usage, raw, hp, atk, def,       ▐"
    echo "    ▌               spatk, spdef, speed                   ▐"
    echo "    ▌   -g, --grep <nama>     Tampilkan data by nama      ▐"
    echo "    ▌   -f, --filter <tipe>   Tampilkan by tipe Pokemon   ▐"
    echo "    ▌-----------------------------------------------------▐"
    echo "================================================================="
    exit 0
}

# Fungsi Info Usage tertinggi
function info_tertinggi() {
    echo "Summary of $FILE"
    tail -n +2 "$FILE" | sort -t',' -k2,2nr | awk -F',' 'NR==1 {print "Highest Adjusted Usage: "$1","$2}'
    tail -n +2 "$FILE" | sort -t',' -k3,3nr | awk -F',' 'NR==1 {print "Highest Raw Usage:      "$1","$3}'
    exit 0
}

# Fungsi Sorting
function sorting_data() {
    if [ -z "$OPTION" ]; then
        echo "Error: Tidak ada metode sort diberikan."
        exit 1
    fi

    declare -A kolom
    kolom=( [name]=1 [usage]=2 [raw]=3 [hp]=6 [atk]=7 [def]=8 [spatk]=9 [spdef]=10 [speed]=11 )

    metode_lc=$(echo "$OPTION" | tr '[:upper:]' '[:lower:]')
    kolom_index=${kolom[$metode_lc]}

    if [ -z "$kolom_index" ]; then
        echo "Error: Metode sort tidak valid."
        exit 1
    fi

    header=$(head -n 1 "$FILE")
    echo "$header"

    if [ "$metode_lc" = "name" ]; then
        tail -n +2 "$FILE" | sort -t, -k$kolom_index,$kolom_index
    else
        tail -n +2 "$FILE" | sort -t, -k$kolom_index,$kolom_index -nr
    fi
    exit 0
}

# Fungsi Grep by nama (REVISI) ( search urut usage%, hanya membaca nama pokemon jangan sampe baca type)
function grep_pokemon() {
    if [ -z "$OPTION" ]; then
        echo "Error: Nama Pokemon tidak diberikan."
        exit 1
    fi

    header=$(head -n 1 "$FILE")
    echo "$header"

    tail -n +2 "$FILE" | awk -F',' -v name="$OPTION" '
        tolower($1) ~ tolower(name)
    ' | sort -t',' -k2,2 -nr

    exit 0
}



# Fungsi Filter by tipe (REVISI) (Filter type pokemon jangan sampai muncul dari nama pokemon)
function filter_tipe() {
    if [ -z "$OPTION" ]; then
        echo "Error: Tipe tidak diberikan."
        exit 1
    fi
    awk -F',' -v tipe="$OPTION" 'NR==1 || tolower($4) == tolower(tipe) || tolower($5) == tolower(tipe)' "$FILE"
    exit 0
}

# Eksekusi perintah
case "$COMMAND" in
    -h|--help)
        bantuan_menu
        ;;
    -i|--info)
        info_tertinggi
        ;;
    -s|--sort)
        sorting_data
        ;;
    -g|--grep)
        grep_pokemon
        ;;
    -f|--filter)
        filter_tipe
        ;;
    *)
	#(REVISI) Error kwtika filter tanpa type
        echo "Error: Opsi tidak dikenali."
        echo "Gunakan -h atau --help untuk bantuan."
        exit 1
        ;;
esac

