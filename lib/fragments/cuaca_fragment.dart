import 'package:flutter/material.dart';

class CuacaFragment extends StatelessWidget {
  const CuacaFragment({super.key});

  // Fungsi utilitas untuk mendapatkan ikon berdasarkan kondisi (Contoh sederhana)
  IconData _getWeatherIcon(String jam) {
    // Logika sederhana: ganti ikon berdasarkan jam
    // Di aplikasi nyata, ini akan didasarkan pada 'kondisi' cuaca
    int hour = int.parse(jam.split(':')[0]);
    if (hour >= 6 && hour < 18) {
      return Icons.cloud_queue; // Ikon siang/berawan
    } else {
      return Icons.wb_cloudy; // Ikon malam/berawan
    }
  }

  // --- Widget untuk Detail Info Tambahan (Kelembapan/Angin) ---
  Widget _buildWeatherDetail(
      IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: color.withOpacity(0.7), fontSize: 12),
        ),
      ],
    );
  }

  // --- Widget untuk Kartu Prakiraan Jam-Jaman ---
  Widget _buildHourlyForecastCard(Map<String, dynamic> data) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data["jam"],
            style: const TextStyle(
              color: Color(0xFF334C80), // Warna biru tua
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            _getWeatherIcon(data["jam"]), // Ikon dinamis
            color: const Color(0xFF4A6DE0),
            size: 30,
          ),
          const SizedBox(height: 8),
          Text(
            "${data["suhu"]}°C",
            style: const TextStyle(
              color: Color(0xFF334C80),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Data cuaca statis
    const String kota = "Bandung";
    const double suhu = 21;
    const String kondisi = "Berawan sebagian";
    const int kelembapan = 55;
    const double kecepatanAngin = 12;

    // 🔹 Data prakiraan jam-jaman
    // Mengganti ikon dengan data IconData (simulasi)
    final List<Map<String, dynamic>> prakiraan = [
      {"jam": "13:00", "suhu": 22},
      {"jam": "14:00", "suhu": 22},
      {"jam": "15:00", "suhu": 23},
      {"jam": "16:00", "suhu": 22},
      {"jam": "17:00", "suhu": 21},
      {"jam": "18:00", "suhu": 20},
      {"jam": "19:00", "suhu": 19},
    ];

    // Warna yang lebih modern
    const Color primaryColor = Color(0xFF4A6DE0); // Biru yang cerah
    const Color darkColor = Color(0xFF334C80); // Biru yang lebih tua

    return Scaffold(
      body: Container(
        // 🚀 Background Gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor, darkColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔹 AppBar kustom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: const Icon(Icons.location_on, color: Colors.white),
                  title: const Text(
                    "Prakiraan Cuaca",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.settings, color: Colors.white),
                    )
                  ],
                ),
              ),

              // 🔹 Bagian atas: kota + suhu besar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan
                  children: [
                    Text(
                      "Sekarang di $kota",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Menggunakan ikon cuaca dinamis (simulasi)
                        Icon(
                          _getWeatherIcon("13:00"), // Mengambil ikon untuk waktu saat ini
                          color: Colors.white,
                          size: 90,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "${suhu.toInt()}°C",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 85,
                            fontWeight: FontWeight.w300, // Lebih tipis untuk modern
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      kondisi,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Kartu informasi tambahan (Diletakkan di dalam container yang lebih gelap)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Latar belakang transparan
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Kelembapan
                      _buildWeatherDetail(
                        Icons.water_drop,
                        "$kelembapan%",
                        "Kelembapan",
                        Colors.white,
                      ),
                      // Divider yang lebih soft
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white30,
                      ),
                      // Kecepatan angin
                      _buildWeatherDetail(
                        Icons.air,
                        "$kecepatanAngin km/h",
                        "Angin",
                        Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Bagian prakiraan jam-jaman (Latar Belakang Putih)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Prakiraan Jam-Jaman",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: prakiraan.length,
                          itemBuilder: (context, index) {
                            return _buildHourlyForecastCard(prakiraan[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Anda bisa menambahkan detail lain di sini, misalnya prakiraan 5 hari
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Lihat Prakiraan 5 Hari →",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}