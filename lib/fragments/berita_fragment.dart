import 'package:flutter/material.dart';

class BeritaFragment extends StatelessWidget {
  const BeritaFragment({super.key});

  // Skema Warna yang sama dengan CuacaFragment
  static const Color primaryColor = Color(0xFF4A6DE0); // Biru yang cerah
  static const Color darkColor = Color(0xFF334C80); // Biru yang lebih tua

  // Data Berita Disesuaikan
  final List<Map<String, String>> beritaList = const [
    {
      'judul': 'Inovasi Teknologi AI Terbaru Dorong Efisiensi Industri 4.0',
      'isi':
          'Perusahaan teknologi global meluncurkan terobosan AI yang mampu mengotomatisasi proses produksi secara signifikan. Ini diharapkan menjadi pendorong utama ekonomi digital.',
      'kategori': 'Teknologi',
    },
    {
      'judul': 'Perubahan Iklim Mempengaruhi Pola Panen di Asia Tenggara',
      'isi':
          'Laporan terbaru menunjukkan bahwa anomali cuaca ekstrem telah mengubah jadwal tanam dan panen, memaksa petani untuk mengadopsi varietas tanaman yang lebih tahan banting.',
      'kategori': 'Lingkungan',
    },
    {
      'judul': 'Pasar Saham Regional Tunjukkan Tren Positif Minggu Ini',
      'isi':
          'Indeks utama mencatatkan kenaikan berkat sentimen positif dari pasar global dan stabilnya kebijakan moneter domestik.',
      'kategori': 'Ekonomi',
    },
    {
      'judul': 'Piala Liga: Tim Lokal Raih Kemenangan Dramatis di Final',
      'isi':
          'Pertandingan sengit berakhir dengan skor 3-2. Pelatih memuji semangat juang tim yang tidak kenal menyerah hingga menit terakhir.',
      'kategori': 'Olahraga',
    },
    {
      'judul': 'Riset Medis Ungkap Potensi Obat Baru untuk Penyakit Langka',
      'isi':
          'Sebuah tim peneliti dari universitas ternama berhasil mengidentifikasi senyawa yang menjanjikan dalam uji coba praklinis.',
      'kategori': 'Kesehatan',
    },
  ];

  // Widget untuk Kartu Berita
  Widget _buildNewsCard(Map<String, String> berita, BuildContext context) {
    // 💡 Perbaikan: Menggunakan operator null aware (??) untuk fallback string.
    final String judul = berita['judul'] ?? 'Judul Tidak Tersedia';
    final String isi = berita['isi'] ?? 'Deskripsi tidak tersedia.';
    final String kategori = berita['kategori'] ?? 'UMUM';

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Aksi ketika berita diklik (detail dialog)
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(
                judul,
                style: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.bold),
              ),
              content: Text(isi),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(color: primaryColor),
                  ),
                )
              ],
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kategori Berita
              Text(
                kategori.toUpperCase(), // Menggunakan variabel lokal yang aman
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: primaryColor.withOpacity(0.8),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              // Judul Berita
              Text(
                judul, // Menggunakan variabel lokal yang aman
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),
              const SizedBox(height: 8),
              // Isi Ringkas
              Text(
                isi, // Menggunakan variabel lokal yang aman
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              // Tombol Baca Selengkapnya
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Baca Selengkapnya",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: primaryColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🚀 Bagian Atas dengan Gradient (seperti CuacaFragment)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primaryColor, darkColor],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: const Icon(Icons.public, color: Colors.white),
                  title: const Text(
                    "Berita Terkini",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.search, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),

          // 🔹 Bagian Bawah: List Berita (Latar Belakang Putih)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: beritaList.length,
                itemBuilder: (context, index) {
                  // Perubahan: Meneruskan context ke _buildNewsCard
                  return _buildNewsCard(beritaList[index], context);
                },
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}