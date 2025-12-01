**Garis Besar Proyek** : Proyek ini bertujuan untuk menganalisis data dari sebuah perusahaan e-commerce, menggunakan SQL untuk membersihkan data dan menjawab berbagai pertanyaan bisnis terkait kinerja penjualan dan pelanggan. 

**1. Data Understanding**: **Cek Data Duplikat** dan **Cek Data Null** dalam proyek

**A. Data Understanding: Cek Data Duplikat**

**Penjelasan Umum**: Sebelum melakukan analisis lebih lanjut, penting untuk memastikan bahwa data yang digunakan bebas dari duplikasi. Duplikasi dapat menyebabkan hasil analisis yang tidak akurat atau menyesatkan. Oleh karena itu, dilakukan pengecekan terhadap setiap tabel untuk memastikan tidak ada data yang terduplikasi, seperti duplikasi ID pelanggan atau transaksi.

**Query**: Query seperti pada file **"cek data duplikat"** bertujuan untuk memeriksa apakah ada duplikasi pada kolom-kolom tertentu dengan menghitung jumlah kemunculan tiap kombinasi nilai. Jika ada nilai yang muncul lebih dari sekali (duplikasi), maka query ini akan menampilkannya.

Setelah menjalankan query diatas didapatkan hasil bahwa tidak ada duplikasi pada data yang digunakan berarti dapat lanjut ke tahap berikutnya. 

**Tujuan pengecekan duplikat data**: untuk memastikan bahwa dataset yang digunakan bersih dari duplikasi. Data yang terduplikasi dapat mengganggu hasil analisis dan memberikan informasi yang tidak akurat, seperti menggandakan total transaksi atau pelanggan.

**B. Data Understanding: Cek Data Null**
**Penjelasan Umum** : Data Null mengacu pada nilai yang tidak ada atau tidak terisi dalam kolom tertentu. Nilai Null dapat mempengaruhi keakuratan analisis, karena data yang hilang dapat menyebabkan kesalahan atau bias dalam hasil. Oleh karena itu, penting untuk memeriksa dan menangani nilai Null di dataset sebelum melakukan analisis lebih lanjut.

**Query** : Query pada file **"cek data NULL"** bertujuan untuk menghitung jumlah nilai Null pada kolom-kolom tertentu, seperti transaction_id, order_id, dan lainnya, menggunakan fungsi case when ... then 1 else 0 end. Jika hasilnya lebih dari 0, berarti terdapat nilai Null pada kolom tersebut. Setelah dilakukan pengecekan data menggunakan query diatas, didapat hasil bahwa tidak ditemukan data NULL pada tabel data.

**Tujuan dari pengecekan data Null** : untuk memastikan bahwa tidak ada data yang hilang yang dapat mempengaruhi analisis. Data yang memiliki nilai Null dapat menyebabkan error dalam perhitungan atau hasil yang bias, sehingga perlu untuk ditangani sebelum proses analisis lebih lanjut.

**2. TASK dan ANALISIS**

**A. Analisis Penjualan per Bulan (2024)**
**Penjelasan Query (Query task 1 pada file)**: Query ini menghitung total penjualan per bulan di tahun 2024 dengan mengambil data dari tabel transaction_detail. Fungsi extract(month from transaction_date) digunakan untuk mendapatkan bulan dari tanggal transaksi. Kemudian, fungsi sum(total_paid) menjumlahkan total pembayaran per bulan. Data dikelompokkan berdasarkan bulan dan diurutkan dari Januari hingga Desember.

**Insight**: Penjualan menunjukkan fluktuasi, dengan penurunan pada bulan Juli dan puncak penjualan pada Desember.

**Rekomendasi**: Optimalkan strategi pemasaran di Q1 dan Q2 serta tingkatkan kapasitas stok menjelang akhir tahun untuk mengantisipasi lonjakan permintaan.

**B. Tren Penjualan per Kategori (2020-2024)**

**Penjelasan Query (Task 2)**: Query ini menghitung jumlah penjualan (quantity) per kategori produk selama periode 2020 hingga 2024. Data diambil dari tabel order_detail dan product_detail, di mana keduanya digabungkan berdasarkan sku_id. Query ini juga menggunakan sum(case when ...) untuk menghitung jumlah penjualan per tahun untuk setiap kategori produk, dengan syarat bahwa transaksi valid (is_valid = 1).

**Insight**: Kategori Food & Beverage dan Fashion & Footwear menunjukkan kontribusi terbesar, sementara kategori seperti Sports Equipment dan Toys & Games menunjukkan penurunan.

**Rekomendasi**: Fokuskan strategi pada kategori unggulan dan dorong kategori yang sedang naik seperti Books & Stationery. Revitalisasi kategori yang menurun dengan promosi atau bundling produk

**C. Analisis Performa Channel per Bulan (Task 3)**

**Penjelasan Query (Task 3)** : dilakukan analisis kinerja tiga channel utama (Website, App Store, dan Offline Store) dengan menghitung jumlah total order dan revenue setelah diskon, serta perhitungan Month-over-Month (MoM) Growth antara tahun 2023 dan 2024 per bulan

**Insight**: Performa channel menunjukkan fluktuasi yang signifikan. App Store mengalami penurunan revenue pada beberapa bulan, meskipun ada lonjakan besar di bulan April dan Desember. Offline Store menunjukkan pertumbuhan agresif awal tahun, dengan Desember mencatatkan lonjakan sangat besar, namun penurunan terjadi di beberapa bulan. Website memiliki performa stabil dengan lonjakan di paruh kedua tahun 2024.

**Rekomendasi**: Perbaiki konsistensi revenue di App Store dengan evaluasi promosi dan program loyalitas, serta optimalkan strategi pada bulan-bulan dengan performa rendah. Manfaatkan potensi Offline Store dengan kampanye musiman dan event khusus, terutama di Desember. Untuk Website, fokuskan pada peningkatan SEO dan promosi digital serta optimasi UI/UX untuk memperkuat pertumbuhan di bulan-bulan lemah.

**D. Analisis Kinerja Funnel - Organic Event (2024)**

**Penjelasan Query (Task 4)**: Query ini menghitung jumlah event dan konversi per channel (seperti Website, App Store, Play Store) untuk event "organic" di tahun 2024. Data diambil dari tabel funnel_detail, di mana hanya event dengan nama "organic" yang dihitung. Fungsi count(*) menghitung total event, sementara count(distinct f.order_id) menghitung total order unik. Rasio konversi dihitung dengan membagi jumlah order unik dengan total event, kemudian dikalikan 100 untuk mendapatkan persentase.

**Insight**: Website menghasilkan traffic terbesar namun dengan conversion rate terendah, sedangkan Play Store memiliki conversion rate tertinggi.

**Rekomendasi**: Tingkatkan konversi di website dengan memperbaiki UX/UI dan implementasikan strategi cross-channel untuk memaksimalkan efektivitas funnel penjualan.

**E. Akuisisi Pelanggan dan Transaksi Pertama**

**Penjelasan Query (Task 5)** : Query ini menggabungkan dua Common Table Expressions (CTE): reg yang mengambil data registrasi pelanggan berdasarkan bulan dan channel registrasi, serta first_tx yang mengambil tanggal transaksi pertama per pelanggan. Query utama kemudian menghitung jumlah pelanggan baru per bulan dan channel, serta menghitung rata-rata waktu antara tanggal registrasi dan transaksi pertama menggunakan fungsi avg(f.first_order_date - r.reg_month).

**Insight**: Mobile App memiliki jumlah registrasi pelanggan baru yang tinggi namun membutuhkan waktu lama untuk melakukan transaksi pertama.

**Rekomendasi**: Percepat konversi pelanggan baru dengan menggunakan push notification, promosi first-order, dan evaluasi UX pada aplikasi untuk mempercepat proses pembelian.

**3. KESIMPULAN** : Proyek ini memberikan gambaran lengkap tentang bagaimana data transaksi dan pelanggan dianalisis menggunakan SQL untuk memperoleh wawasan tentang kinerja penjualan dan efektivitas channel pemasaran. Beberapa rekomendasi utama termasuk mengoptimalkan promosi di awal tahun, memperbaiki konversi di website, dan meningkatkan integrasi antar channel untuk mendukung strategi pertumbuhan bisnis.
