echo "==========Download CSV File 'Catatan Misterius'=========="
curl -L -o reading_data.csv "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download"
echo -e "\n"

echo "============================================================="
echo "|      Masuki Dunia Petualangan Buku Poppo dan Siroyo!      |"
echo "============================================================="
echo "| Pilih opsi yang ingin diproses:                           |"
echo "|-----------------------------------------------------------|"
echo "| a) Jumlah buku yang dibaca oleh 'Chris Hemsworth'         |"
echo "| b) Rata-rata durasi membaca dengan 'Tablet'               |"
echo "| c) Pembaca dengan rating tertinggi                        |"
echo "| d) Genre paling populer di Asia setelah 2023              |"
echo "|-----------------------------------------------------------|"
echo "| Masukkan opsi (a/b/c/d):                                  |"
echo "============================================================="
echo "Jawaban :" 

# Ambil input pertama kali untuk opsi
read opsi

while true; do
    # Jawaban opsi A
    if [ "$opsi" == "a" ]; then
        echo ""
        count=$(awk -F',' '$2 == "Chris Hemsworth" {count++} END {print count}' reading_data.csv)
        echo "Chris Hemsworth membaca $count buku."
        echo "============================================================="
        echo ""

    # Jawaban opsi B
    elif [ "$opsi" == "b" ]; then
        echo ""
        awk -F',' 'NR > 1 && $8 == "Tablet" {
        sum += $6;
        count++;
        }
        END {
            ave = sum / count;
            print "Rata-rata durasi membaca dengan Tablet adalah", ave, "menit";
        }' reading_data.csv
        echo "============================================================="
        echo ""

    # Jawaban opsi C
    elif [ "$opsi" == "c" ]; then
        echo ""
        awk -F, 'NR > 1 && ($7 > ratingMax) {
        ratingMax = $7; nama = $2; buku = $3
        } 
        END {
            print "Pembaca dengan rating tertinggi:", nama, "-", buku, "-", ratingMax
        }' reading_data.csv
        echo "============================================================="
        echo ""

    # Jawaban opsi D
    elif [ "$opsi" == "d" ]; then
        echo ""
        awk -F, '$9 == "Asia" && $5 > "2023-12-31" {print $0}' reading_data.csv |       
        awk -F, '{print $4}' | sort | uniq -c |sort -nr |head -n 1 |   
        awk '{print "Genre paling populer di Asia setelah 2023 adalah "$2 " dengan " $1 " buku"}'
        echo "============================================================="
        echo ""

    else
        # Jika pilihan tidak valid
        echo ""
        echo "==========================================="
        echo "          Pilihan tidak valid              "
        echo "==========================================="
        echo "Harap pilih a, b, c, atau d."
        echo "==========================================="
    fi

    # Tanyakan apakah ingin memilih opsi lain setelah eksekusi
    echo ""
    echo "Apakah Anda ingin memilih opsi lain? (y / n)"
    read pilih_lagi
    
    # Jika pilihannya "Tidak", keluar dari loop dan selesai
    if [ "$pilih_lagi" == "n" ]; then
        echo ""
        echo "============================================================="
        echo "Terima kasih telah menggunakan Analisis Buku. Sampai jumpa!"
        echo "============================================================="
        echo ""
        break
    fi

    # Jika pilihannya "Ya", maka meminta input untuk opsi lagi
    if [ "$pilih_lagi" == "y" ]; then
        echo "Masukkan opsi (a/b/c/d):"
        read opsi
    fi

done
