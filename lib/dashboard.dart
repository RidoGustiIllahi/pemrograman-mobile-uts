import 'package:flutter/material.dart';
import 'fragments/biodata_fragment.dart';
import 'fragments/kontak_fragment.dart';
import 'fragments/kalkulator_fragment.dart';
import 'fragments/cuaca_fragment.dart';
import 'fragments/berita_fragment.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BiodataFragment(),
    KontakFragment(),
    KalkulatorFragment(),
    CuacaFragment(),
    BeritaFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Biodata'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Kontak'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Kalkulator'),
          BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Cuaca'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Berita'),
        ],
      ),
    );
  }
}
