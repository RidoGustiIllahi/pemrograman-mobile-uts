import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/foto.png'), // ganti dengan fotomu
            ),
            const SizedBox(height: 20),
            const Text(
              "Aplikasi Dashboard",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("NIM: 152023169", style: TextStyle(color: Colors.white70, fontSize: 18)),
            const Text("Nama: Rido Gusti Illahi", style: TextStyle(color: Colors.white70, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
