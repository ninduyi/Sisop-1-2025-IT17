# Praktikum Sistem Operasi Modul 1 - IT17

## Anggota Kelompok

| NRP        | Nama                            |
|:----------:|:-------------------------------:|
| 5027241006 | Nabilah Anindya Paramesti       |
| 5027241092 | Muhammad Khairul Yahya          |
| 5027241002 | Balqis Sani Sabillah            |


## Daftar Isi

- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)

# Soal 1
_**Oleh : Nabilah Anindya Paramesti**_

## Deskripsi Soal
Di sebuah desa kecil yang dikelilingi bukit hijau, Poppo dan Siroyo, dua sahabat karib, sering duduk di bawah pohon tua sambil membayangkan petualangan besar. Poppo, yang ceria dan penuh semangat, baru menemukan kesenangan dalam dunia buku, sementara Siroyo, dengan otaknya yang tajam, suka menganalisis segala hal. Suatu hari, mereka menemukan tablet ajaib berisi catatan misterius bernama [reading_data.csv](https://drive.google.com/file/d/1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV/view?usp=sharing). Dengan bantuan keajaiban **awk**, mereka memutuskan untuk menjelajahi rahasia di balik data itu, siap menghadapi tantangan demi tantangan dalam petualangan baru mereka

> Note :
Seluruh command dimasukkan kedalam 1 file dan gunakan kondisi if else untuk setiap soalnya.

## Jawaban
### Soal Tipe A
> Poppo baru saja mulai melihat tablet ajaib dan terpukau dengan kekerenan orang bernama “Chris Hemsworth”. Poppo jadi sangat ingin tahu berapa banyak buku yang dibaca oleh “Chris Hemsworth”. Bantu Poppo menghitung jumlah baris di tablet ajaib yang menunjukkan buku-buku yang dibaca oleh Chris Hemsworth.

### Penyelesaian
Untuk mengerjakan soal nomor 1, kita harus memiliki data 'reading_data.csv'. Disini saya menggunakan command `curl` untuk mendownload data tersebut.
```bash
# Download file CSV dari Google Drive
echo "==========Download CSV File 'Catatan Misterius'=========="
curl -L -o reading_data.csv "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download"
```
Keterangan :
- `curl` = Perintah untuk mengunduh data dari internet.
- `-L`   = Menginstruksikan curl untuk mengikuti redirect jika URL mengarah ke lokasi lain jika ada.
- `-o reading_data.csv`= Menyimpan file yang diunduh dengan nama reading_data.csv di direktori saat ini.

Lalu diikuti dengan URL dari file CSV yang dibungkus dengan tanda `" "` (petik).

Setelah mendownload file tersebut kita baru mengerjakan perintah soal yaitu menghitung banyak buku yang dibaca oleh `Chris Hemsworth` dengan menggunakan command
```bash
# Jumlah buku yang dibaca oleh 'Chris Hemsworth'
count=$(awk -F',' '$2 == "Chris Hemsworth" {count++} END {print count}' reading_data.csv)
echo "Chris Hemsworth membaca $count buku."
```
Perintah ini menghitung berapa kali "Chris Hemsworth" muncul di kolom **kedua** file CSV lalu menyimpannya di variabel **count** dan menampilkan jumlahnya menggunakan command `echo`.

### Soal Tipe B
> Setelah menemukan tablet ajaib, Siroyo mulai penasaran dengan kebiasaan membaca yang tersimpan di dalamnya. Ia mulai menggunakan tablet ajaib dan bergumam sambil meneliti, “Aku ingin tahu berapa lama rata-rata mereka membaca dengan benda ini”. Bantu Siroyo untuk menghitung rata-rata durasi membaca (Reading_Duration_Minutes) untuk buku-buku yang dibaca menggunakan “Tablet”

### Penyelesaian
Kita diminta untuk menghitung rata-rata durasi membaca (Reading_Duration_Minutes) untuk buku-buku yang dibaca menggunakan “Tablet”.
```bash
# Rata-rata durasi membaca dengan 'Tablet' 
awk -F',' 'NR > 1 && $8 == "Tablet" {
        sum += $6;
        count++;
        }
        END {
            ave = sum / count;
            print "Rata-rata durasi membaca dengan Tablet adalah", ave, "menit";
        }' reading_data.csv
```
Keterangan :
- `awk -F',' 'NR > 1 && $8 == "Tablet"` = berarti memproses semua baris kecuali baris pertama (header) dan hanya memilih baris yang kolom kedelapan berisi "Tablet".
- `{sum += $6; count++}` = Menambahkan nilai kolom keenam (durasi membaca) ke variabel sum dan menghitung jumlah baris dengan count.
- `END {ave = sum / count; print "Rata-rata durasi membaca dengan Tablet adalah", ave, "menit"}` =  Setelah memproses semua baris, menghitung rata-rata dan menampilkan hasilnya.

### Soal Tipe C
> Sementara Siroyo sibuk menganalisis tablet ajaib, Poppo duduk disampingnya dengan ide cemerlang. “Kalau kita sudah tahu cara mereka membaca, aku ingin memberi hadiah ke temen yang paling suka sama bukunya!”. Ia pun mencari siapa yang memberikan rating tertinggi untuk buku yang dibaca (Rating) beserta nama (Name) dan judul bukunya (Book_Title).

### Penyelesaian
Kita diminta mencari siapa yang memberikan rating tertinggi untuk buku yang dibaca (Rating) beserta nama (Name) dan judul bukunya (Book_Title).
```bash
# Pembaca dengan rating tertinggi
awk -F, 'NR > 1 && ($7 > ratingMax) {
        ratingMax = $7; nama = $2; buku = $3
        } 
        END {
            print "Pembaca dengan rating tertinggi:", nama, "-", buku, "-", ratingMax
        }' reading_data.csv
```
Keterangan :
- `awk -F, 'NR > 1 && ($7 > ratingMax)` = memproses semua baris kecuali baris pertama (header) dan membandingkan nilai di kolom ketujuh dengan `ratingMax` untuk menemukan rating tertinggi.
- `{ratingMax = $7; nama = $2; buku = $3}` = Jika rating di kolom ketujuh lebih besar dari ratingMax, maka menyimpan nilai rating tersebut ke ratingMax, nama pembaca di kolom kedua ke variabel nama, dan buku di kolom ketiga ke variabel buku
- `END {print "Pembaca dengan rating tertinggi:", nama, "-", buku, "-", ratingMax}` = Setelah memproses semua baris, menampilkan pembaca dengan rating tertinggi beserta nama, buku yang dibaca, dan rating tertinggi.

### Soal Tipe D
> Siroyo mengusap keningnya dan berkata, "Petualangan kita belum selesai! Aku harus bikin laporan untuk klub buku besok." Ia ingin membuat laporan yang istimewa dengan tablet ajaib itu, fokus pada teman-teman di Asia. "Aku penasaran genre apa yang paling populer di sana setelah tahun 2023," katanya, membuka reading_data.csv sekali lagi. Bantu Siroyo menganalisis data untuk menemukan genre yang paling sering dibaca di Asia setelah 31 Desember 2023, beserta jumlahnya, agar laporannya jadi yang terbaik di klub.

### Penyelesaian
Kita diminta menemukan genre yang paling sering dibaca di Asia setelah 31 Desember 2023 beserta jumlahnya.
```bash
# Genre paling populer di Asia setelah 2023  
awk -F, '$9 == "Asia" && $5 > "2023-12-31" {print $0}' reading_data.csv |       
        awk -F, '{print $4}' | sort | uniq -c |sort -nr |head -n 1 |   
        awk '{print "Genre paling populer di Asia setelah 2023 adalah "$2 " dengan " $1 " buku"}'
```
Keterangan :
- `awk -F, '$9 == "Asia" && $5 > "2023-12-31" {print $0}' reading_data.csv` = mencari baris demi baris di file `reading_data.csv`
    - `$9 == "Asia"` = Memilih baris yang kolom kesembilan berisi "Asia".
    - `$5 > "2023-12-31"` = Memilih baris yang kolom kelima (tanggal) lebih besar dari 31 Desember 2023.
    - `{print $0}` = Menampilkan seluruh baris yang memenuhi kondisi tersebut.
lalu di pipe (outputnya dijadikan input perintah selanjutnya)
- `awk -F, '{print $4}' | sort | uniq -c |sort -nr |head -n 1 `
    - `{print $4}`: Menampilkan kolom keempat (genre) dari hasil baris yang telah dipilih sebelumnya.
    - `sort` = Mengurutkan genre yang telah dipilih secara alfabetis.
    - `sort -nr` = Mengurutkan hasil berdasarkan jumlah kemunculan genre secara menurun (dari yang paling banyak).
    - `head -n 1` = Menampilkan genre dengan jumlah kemunculan terbanyak.
lalu di pipe lagi
- `awk '{print "Genre paling populer di Asia setelah 2023 adalah "$2 " dengan " $1 " buku"}'` = Mencetak genre paling populer beserta jumlah kemunculannya dalam kalimat yang sudah ditentukan, menggunakan kolom pertama (jumlah) dan kolom kedua (genre).

### Penyelesaian Keseluruhan
Untuk memenuhi syarat penggunaan kondisi `if else` pada setiap soal, kita dapat membuat pilihan opsi yang memungkinkan pengguna memilih jawaban yang ingin ditampilkan. Dengan menggunakan `if else`, kita dapat memeriksa kondisi tertentu dan menampilkan jawaban yang sesuai berdasarkan pilihan kita.

```bash
# Opsi untuk memilih informasi mana yang ingin diketahui
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
```
command `read` berfungsi untuk menyimpan input yang dimasukkan ke variabel `opsi`.

Lalu saya menggunakan **loop** dan juga kondisi **if else** untuk menampilkan jawaban yang sesuai
```bash
while true; do
    # Jawaban opsi A
    if [ "$opsi" == "a" ]; then
        # ------command untuk jawaban A------ #

    # Jawaban opsi B
    elif [ "$opsi" == "b" ]; then
        # ------command untuk jawaban B------ #

    # Jawaban opsi C
    elif [ "$opsi" == "c" ]; then
        # ------command untuk jawaban C------ #

    # Jawaban opsi D
    elif [ "$opsi" == "d" ]; then
        # ------command untuk jawaban D------ #

    else
        # Jika pilihan tidak valid
        echo "          Pilihan tidak valid              "
        echo "==========================================="
        echo "Harap pilih a, b, c, atau d."
    fi

    # Tanyakan apakah ingin memilih opsi lain setelah eksekusi
    echo ""
    echo "Apakah Anda ingin memilih opsi lain? (y / n)"
    read pilih_lagi
    
    # Jika pilihannya "n", keluar dari loop dan selesai
    if [ "$pilih_lagi" == "n" ]; then
        echo "Terima kasih telah menggunakan Analisis Buku. Sampai jumpa!"
        break
    fi

    # Jika pilihannya "y", maka meminta input untuk opsi lagi
    if [ "$pilih_lagi" == "y" ]; then
        echo "Masukkan opsi (a/b/c/d):"
        read opsi
    fi

done
```
Keterangan :
- `while true; do` = awal dari sebuah loop, yang berarti perintah di dalamnya akan terus dijalankan hingga kondisi tertentu terpenuhi (ada **break**) untuk keluar dari loop.
- Kondisi `if`, `elif`, dan `else` `[ "$opsi" == "d" ]; then` = Memeriksa apakah variabel `opsi` bernilai "...". Jika benar, perintah untuk jawaban ... akan dijalankan.
- Untuk menanyakan pilihan lanjutan `echo "Apakah Anda ingin memilih opsi lain? (y / n)"`
    - `read pilih_lagi` = untuk membaca input pengguna.
    -   Jika input `n`= menampilkan pesan "Terima kasih telah menggunakan Analisis Buku. Sampai jumpa!" dan keluar dari loop menggunakan `break`.
    - Jika input `y` = meminta input untuk memilih opsi lagi dengan perintah `echo "Masukkan opsi (a/b/c/d):"` dan membaca input ke dalam variabel `opsi`.
- Jika memilih untuk melanjutkan (memilih `y` dan memasukkan `opsi a/b/c/d`), program kembali ke awal loop dan meminta input `opsi` baru

# Soal 2
_**Oleh : ?**_

### Deskripsi Soal
Anda merupakan seorang “Observer”, dari banyak dunia yang dibuat dari ingatan yang berbentuk “fragments” - yang berisi kemungkinan yang dapat terjadi di dunia lain. Namun, akhir-akhir ini terdapat anomali-anomali yang seharusnya tidak terjadi, perpindahan “fragments” di berbagai dunia, yang kemungkinan terjadi dikarenakan seorang “Seeker” yang berubah menjadi “Ascendant”, atau dalam kata lain, “God”. Tidak semua “Observer” menjadi “Player”, tetapi disini anda ditugaskan untuk ikut serta dalam menjaga equilibrium dari dunia-dunia yang terbuat dari “Arcaea”.


### Penyelesaian
#### A. “First Step in a New World”
> Tugas pertama, dikarenakan kejadian “Axiom of The End” yang semakin mendekat, diperlukan sistem untuk mencatat “Player” aktif agar terpisah dari “Observer”. Buatlah dua shell script, login.sh dan register.sh, yang dimana database “Player” disimpan di /data/player.csv. Untuk register, parameter yang dipakai yaitu email, username, dan password. Untuk login, parameter yang dipakai yaitu email dan password.

# Soal 3
_**Oleh : Muhammad Khairul Yahya**_

### Deskripsi Soal
Untuk merayakan ulang tahun ke 52 album The Dark Side of the Moon, tim PR Pink Floyd mengadakan sebuah lomba dimana peserta diminta untuk membuat sebuah script bertemakan setidaknya 5 dari 10 lagu dalam album tersebut. Sebagai salah satu peserta, kamu memutuskan untuk memilih Speak to Me, On the Run, Time, Money, dan Brain Damage. Saat program ini dijalankan, terminal harus dibersihkan terlebih dahulu agar tidak mengganggu tampilan dari fungsi fungsi yang kamu buat. Program ini dijalankan dengan cara ./dsotm.sh --play=”<Track>” dengan Track sebagai nama nama lagu yang kamu pilih.

### Penyelesaian

### Dokumentasi


# Soal 4
_**Oleh : Balqis Sani Sabillah**_
