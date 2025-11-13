import 'package:flutter/material.dart';

class KontakFragment extends StatelessWidget {
  const KontakFragment({super.key});

  // Warna yang digunakan di KalkulatorFragment
  static const Color primaryColor = Color(0xFF4A6DE0); // Biru yang cerah
  static const Color darkColor = Color(0xFF334C80); // Biru yang lebih tua

  // 🔹 Daftar kontak favorit
  final List<Map<String, String>> favoriteContacts = const [
    {"name": "Alice", "image": "assets/foto.png"},
    {"name": "Bob", "image": "assets/foto.png"},
    {"name": "Charlie", "image": "assets/foto.png"},
  ];

  // 🔹 Daftar kontak biasa
  final List<Map<String, String>> contactList = const [
    {
      "name": "Diana",
      "desc": "Friend from school",
      "image": "assets/foto.png"
    },
    {
      "name": "Evelyn",
      "desc": "Work partner",
      "image": "assets/foto.png"
    },
    {
      "name": "Frank",
      "desc": "Neighbor",
      "image": "assets/foto.png"
    },
    {
      "name": "Grace",
      "desc": "College friend",
      "image": "assets/foto.png"
    },
    {
      "name": "Henry",
      "desc": "Old classmate",
      "image": "assets/foto.png"
    },
    {
      "name": "Ivy",
      "desc": "Gym buddy",
      "image": "assets/foto.png"
    },
    {
      "name": "Jack",
      "desc": "Family friend",
      "image": "assets/foto.png"
    },
    {
      "name": "Karen",
      "desc": "Co-worker",
      "image": "assets/foto.png"
    },
    {
      "name": "Leo",
      "desc": "Gaming friend",
      "image": "assets/foto.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background Gradient seperti KalkulatorFragment
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor, darkColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 AppBar Kustom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    "Kontak",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.perm_contact_cal, color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // 🔹 Judul Favorite
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Kontak Favorit",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // 🔹 Daftar Favorite (dinamis)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: favoriteContacts.map((contact) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
                      // Menggunakan _buildFavorite yang sudah diperbarui
                      child: _buildFavorite(contact["image"]!, contact["name"]!),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Daftar Contact (Konten utama dengan latar belakang putih)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 30, right: 30, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Daftar Kontak",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: darkColor,
                              ),
                            ),
                            Icon(Icons.search, color: darkColor.withOpacity(0.7)),
                          ],
                        ),
                      ),
                      // 🔹 ListView dari variable contactList
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: contactList.length,
                          itemBuilder: (context, index) {
                            final contact = contactList[index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 25, // Ukuran avatar disesuaikan
                                backgroundImage: AssetImage(contact["image"]!),
                                backgroundColor: primaryColor.withOpacity(0.2), // Latar belakang avatar
                              ),
                              title: Text(
                                contact["name"]!,
                                style: const TextStyle(fontWeight: FontWeight.w600, color: darkColor),
                              ),
                              subtitle: Text(
                                contact["desc"]!,
                                style: TextStyle(color: darkColor.withOpacity(0.7)),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryColor, // Tombol telepon dengan warna primary
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            );
                          },
                        ),
                      ),
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

  // 🔹 Widget kecil untuk favorite contact (Disesuaikan)
  Widget _buildFavorite(String imagePath, String name) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3), // Border putih
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
            backgroundColor: primaryColor.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}