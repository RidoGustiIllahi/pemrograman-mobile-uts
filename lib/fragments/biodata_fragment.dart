import 'package:flutter/material.dart';

class BiodataFragment extends StatelessWidget {
  const BiodataFragment({super.key});

  // Warna yang digunakan
  static const Color primaryColor = Color(0xFF4A6DE0);
  static const Color darkColor = Color(0xFF334C80);

  // Widget untuk TextField dengan warna tema
  Widget _buildThemedTextField(
      TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: darkColor),
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: darkColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      cursorColor: primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController myController = TextEditingController();

    final List<String> programStudiList = [
      "Teknik Informatika",
      "Teknik Sipil",
      "Teknik Elektro",
      "Desain Komunikasi Visual",
      "Arsitektur",
    ];

    // 🟦 Gunakan StatefulBuilder di sekitar variabel state agar bisa berubah
    String? selectedProdi = programStudiList[0];
    String? gender;
    DateTime? selectedDate;

    return Scaffold(
      backgroundColor: Colors.white,
      body: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // --- Header ---
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [primaryColor, darkColor],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      child: const Text(
                        "Profil Pengguna",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      width: 350,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: darkColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: primaryColor,
                              backgroundImage:
                                  const AssetImage('assets/foto.png'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Rido Gusti Illahi",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: darkColor),
                          ),
                          const Text(
                            "152023169",
                            style:
                                TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const Divider(
                            height: 25,
                            thickness: 1,
                            indent: 50,
                            endIndent: 50,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 300,
                            child: Text(
                              "Informatika - Institut Teknologi Nasional Bandung",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: darkColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // --- Form ---
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dropdown Program Studi
                      const Text(
                        "Pilih Program Studi:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkColor),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedProdi,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon:
                              const Icon(Icons.school, color: primaryColor),
                        ),
                        items: programStudiList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(color: darkColor)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProdi = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      // Radio Gender
                      const Text(
                        "Pilih Jenis Kelamin:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkColor),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Pria',
                            groupValue: gender,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          const Text("Pria",
                              style: TextStyle(color: darkColor)),
                          Radio<String>(
                            value: 'Wanita',
                            groupValue: gender,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),
                          const Text("Wanita",
                              style: TextStyle(color: darkColor)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Tanggal Lahir
                      const Text(
                        "Pilih Tanggal Lahir:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkColor),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime(2000),
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: primaryColor,
                                    onPrimary: Colors.white,
                                    onSurface: darkColor,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: darkColor.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: primaryColor),
                              const SizedBox(width: 10),
                              Text(
                                selectedDate == null
                                    ? "Belum memilih tanggal"
                                    : "${selectedDate!.day.toString().padLeft(2, '0')}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.year}",
                                style: const TextStyle(
                                    fontSize: 16, color: darkColor),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      _buildThemedTextField(
                        myController,
                        'Kritik dan Saran',
                        Icons.feedback,
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Data disimpan.\nProdi: $selectedProdi\nGender: $gender\nTanggal: ${selectedDate != null ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}" : "-"}\nKritik: ${myController.text}",
                                ),
                                backgroundColor: primaryColor,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            "SIMPAN DATA",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
