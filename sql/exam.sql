--=== soal no 1
select items.name,
        count(*) as jumlah_penjualan,
        items.price,
        count(*)*items.price as total_pendapatan
from sales_records
join items on sales_records.item_id = items.id
GROUP BY items.name, items.price
order by count(*)* items.price desc 
limit 5
-- 
select items.name,
        count(*) as jumlah_penjualan,
        items.price,
        sum(items.price) as total_pendapatan
from sales_records
join items on sales_records.item_id = items.id
GROUP BY items.name, items.price
order by sum(items.price) desc 
limit 5


-- hasil analisa
-- Sekarang kita mendapat 5 item yang menghasilkan pendapatan  tertinggi dan mengapa itu menghasilkan pendapatan tinggi.
-- Dalam data ini, item teratas adalah "jaket kulit". Kita bisa lihat  kalau jumlah penjualannya tidak terlalu besar tapi harga satuannya  sangat tinggi, yang membuatnya menjadi item teratas.
-- Sebaliknya, “celana denim” dan “rok” memiliki harga yang lebih  rendah tetapi menghasilkan keuntungan besar karena jumlah  penjualan yang besar.
-- Dari Permintaan data no. 1 dan 2, Anda juga dapat melihat  berapa jumlah 5 item teratas untuk total pendapatan situs ini,  yaitu (Jumlah dari total_revenue dari 5 teratas) / 46779 = 50,8%.

--===soal no 2
-- versi 1
select items.name,
        (items.price - items.cost) as laba,
        1.0* (items.price - items.cost) / (items.price)*100 as persentase_laba,
        count(*)* (items.price - items.cost) as total_profit
from sales_records
join items on sales_records.item_id = items.id
where items.id = 23 
OR items.id = 30 
OR items.id = 3
OR items.id = 17
OR items.id = 1
GROUP BY items.name, laba, persentase_laba
order by count(*)* items.price DESC

-- versi 2
select items.name,
        (items.price - items.cost) as laba,
        1.0* (items.price - items.cost) / (items.price)*100 as persentase_laba,
        count(*)* (items.price - items.cost) as total_profit
from sales_records
join items on sales_records.item_id = items.id
where  items on IN (
    select items.id 
    from sales_records
    join items on sales_records.item_id = items.id
    GROUP by items.id
    order by count(*)* items.price desc 
limit 5

)
GROUP BY items.name, laba, persentase_laba
order by count(*)* items.price DESC

-- Analisis Hasil
-- Apakah Anda ingat bahwa tingkat keuntungan seluruh situs  adalah 67% (dari permintaan data no. 1)? Anda dapat  membandingkan tingkat keuntungan setiap item dengannya.
-- Di antara 5 item yang menghasilkan pendapatan teratas,  "jaket kulit", "mantel merah", dan "rok" memiliki tingkat  keuntungan yang lebih tinggi dan 2 lainnya memiliki tingkat  keuntungan yang lebih rendah daripada yang ada di seluruh  situs.
-- Selain itu, Anda juga dapat melihat berapa jumlah 5 item  akun total keuntungan situs ini
-- (Jumlah total laba dari 5 item) / 31.428 = 51,7%.
-- Sekarang Anda dapat menyimpulkan bahwa 5 item penghasil  pendapatan teratas juga menghasilkan untung besar.

--=== soal no 3dan4
select items.name as name,
        (items.price - items.cost) as laba,
        1.0* (items.price - items.cost) / (items.price)*100 as persentase_laba,
        count(*)* (items.price - items.cost) as total_laba
from sales_records
join items on sales_records.item_id = items.id
GROUP BY name. laba, persentase_laba, total_laba
order by count(*)* laba desc 
limit 5

-- Analisis Hasil
-- Dari 5 item penghasil pendapatan teratas, 4 item juga  menempati peringkat 5 item penghasil laba teratas.
-- Sekarang Anda dapat memutuskan untuk tetap menjual 5  item penghasil pendapatan teratas karena juga  menguntungkan. Tapi terkadang ada barang yang laku tapi  untung sedikit. Dalam hal ini, Anda dapat menyimpulkan  mungkin Anda harus mengubah taktik penjualan Anda.
-- Kita mendapat "sweater" dalam latihan ini sebagai item  penghasil keuntungan No. 4. Anehnya, tingkat  keuntungannya luar biasa tinggi, 94%. Artinya, Anda bisa  mencoba mendiskon barang (masih menguntungkan) dan  meningkatkan kuantitas penjualan untuk memaksimalkan  total keuntungan.


-- no 4 Cari tahu 5 item penghasil pendapatan terburuk 
select items.name,
        count(*) as jumlah_penjualan,
        items.price,
        count(*)*items.prince as total_pendapatan
from sales_records
join items on sales_records.item_id = items.id
GROUP BY items.name, items.price
order by total_pendapatan desc 
limit 5


--=== soal no 5
select items.name as name,
        (items.price - items.cost) as laba,
        1.0* (items.price - items.cost) / (items.price)*100 as persentase_laba,
        count(*)* (items.price - items.cost) as total_laba
from sales_records
join items on sales_records.item_id = items.id
GROUP BY name. laba, persentase_laba, total_laba
order by total_laba desc 
limit 5

-- Analisis hasil
-- Jumlah keuntungan barang adalah $ 942, yang hanya 3,0%  dari seluruh pendapatan.
-- Tingkat keuntungan dari “kaos abu-abu” dan “kaos biru  tua” sangat kecil dan “kaos abu-abu” juga merupakan salah  satu item yang menghasilkan pendapatan terburuk. Anda  harus melakukan sesuatu untuk barang-barang ini.
-- Tingkat keuntungan dari “kaus kaki” tidak buruk meskipun  keuntungannya sendiri sangat kecil. Dalam hal ini, menjual 3  pasang kaus kaki dengan sedikit diskon mungkin berhasil!

--=== soal no 6
select count(distinct sales_records.user_id) as pengguna_aktif,
    1.0 * 100 * count(distinct sales_records.user_id) / 
    (select count(*)
    from users
    ) as persentase_aktif
from sales_records
-- Dari 325 pengguna  (87%) benar-benar membeli barang.
-- Untuk mendapatkan lebih banyak keuntungan, Anda  perlu mengaktifkan pengguna yang tidak aktif. Anda  dapat mencoba mengirim email atau semacamnya.
-- Cara lain untuk mendapatkan lebih banyak  keuntungan adalah membuat pengguna aktif  berbelanja lebih sering atau membeli barang yang  lebih mahal.
-- Selanjutnya, mari kita pelajari tentang frekuensi  rata-rata dan pengeluaran rata-rata pengguna aktif!


--=== soal no 7
select 
    1.0 * count(*) / count(distinct sales_records.user_id) as jumlah_rata2_penjualan,
    1.0 * sum(items.price) / count(distinct sales_records.user_id) as pengeluaran_rata2,
    (
        1.0 * sum(items.price) / count(distinct sales_records.user_id) 
    ) / 
    (
        1.0 * count(*) / count(distinct sales_records.user_id) 
    ) as rata_pengeluaran_per_belanjaan
from sales_records
join items on sales_records.item_id = items.id


