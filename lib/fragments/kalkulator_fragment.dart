import 'dart:math';
import 'package:flutter/material.dart';

class KalkulatorFragment extends StatefulWidget {
  const KalkulatorFragment({super.key});

  @override
  State<KalkulatorFragment> createState() => _KalkulatorFragmentState();
}

class _KalkulatorFragmentState extends State<KalkulatorFragment> {
  final TextEditingController _inputController = TextEditingController();
  String _expression = '';
  String _result = '0';

  // Warna yang digunakan di CuacaFragment
  static const Color primaryColor = Color(0xFF4A6DE0); // Biru yang cerah
  static const Color darkColor = Color(0xFF334C80); // Biru yang lebih tua
  
  // Fungsi yang sudah ada (tidak diubah)
  void _tambahKarakter(String char) {
    setState(() {
      _expression += char;
      _inputController.text = _expression;
    });
  }

  void _hapusSemua() {
    setState(() {
      _expression = '';
      _result = '0';
      _inputController.clear();
    });
  }

  void _hitung() {
    try {
      String ekspresi = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      final result = _evaluateExpression(ekspresi);
      setState(() {
        // Hanya tampilkan 5 desimal jika hasil bukan bilangan bulat
        if (result == result.toInt()) {
          _result = result.toInt().toString();
        } else {
          _result = result.toStringAsFixed(5);
        }
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  double _evaluateExpression(String ekspresi) {
    try {
      final exp = ekspresi.replaceAll(' ', '');
      return _calculate(exp);
    } catch (_) {
      return double.nan;
    }
  }

  // Evaluasi sederhana dengan priority (kuadrat/akar dulu, lalu +-*/)
  double _calculate(String exp) {
    // Tangani operasi akar dan kuadrat
    if (exp.contains('√')) {
      final parts = exp.split('√');
      if (parts.length > 1) {
        // Asumsi format sederhana: √angka
        return sqrt(double.parse(parts.last));
      }
    }
    if (exp.contains('^')) {
      final parts = exp.split('^');
      if (parts.length == 2) {
        return pow(double.parse(parts[0]), double.parse(parts[1])).toDouble();
      }
    }

    // Gunakan parser sederhana untuk +-*/
    List<String> tokens = exp.split(RegExp(r'([+\-*/])')).where((t) => t.isNotEmpty).toList();
    List<String> ops = RegExp(r'[+\-*/]').allMatches(exp).map((m) => m.group(0)!).toList();

    if (tokens.isEmpty) return 0.0;
    
    double value = double.parse(tokens[0]);
    for (int i = 0; i < ops.length; i++) {
      if (i + 1 < tokens.length) {
        double next = double.parse(tokens[i + 1]);
        switch (ops[i]) {
          case '+':
            value += next;
            break;
          case '-':
            value -= next;
            break;
          case '*':
            value *= next;
            break;
          case '/':
            // Hindari pembagian dengan nol
            if (next == 0) return double.nan; 
            value /= next;
            break;
        }
      }
    }
    return value;
  }
  
  // Fungsi untuk mendapatkan warna tombol yang baru
  Color _getButtonColor(String btn) {
    if (btn == 'C') return Colors.red.shade400; // Merah untuk clear
    if (btn == '=') {
      return Colors.green.shade600; // Hijau untuk hitung
    }
    if (['+', '-', '×', '÷', '^', '√'].contains(btn)) return primaryColor; // Biru untuk operator
    return Colors.grey.shade100; // Putih keabuan untuk angka/titik
  }
  
  // Fungsi untuk mendapatkan warna teks tombol
  Color _getButtonTextColor(String btn) {
    if (['C', '=', '+', '-', '×', '÷', '^', '√'].contains(btn)) {
      return Colors.white; // Teks putih untuk tombol operator/aksi
    }
    return darkColor; // Teks biru tua untuk tombol angka/titik
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', '×'],
      ['1', '2', '3', '-'],
      ['0', '.', '^', '+'],
      ['√', 'C', '='],
    ];

    return Scaffold(
      body: Container(
        // Background Gradient seperti CuacaFragment
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
              // AppBar Kustom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    "Kalkulator",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  actions: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.calculate, color: Colors.white),
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 20),

              // Bagian Input/Hasil dengan Box Styling
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white, // Latar belakang putih
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression.isEmpty ? '0' : _expression,
                      style: TextStyle(fontSize: 28, color: darkColor.withOpacity(0.7)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Divider(color: darkColor, height: 20),
                    Text(
                      "$_result",
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: darkColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Kalkulator
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    itemCount: buttons.expand((row) => row).length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.2, // Tombol sedikit lebih lebar
                    ),
                    itemBuilder: (context, index) {
                      final flatButtons = buttons.expand((row) => row).toList();
                      final btn = flatButtons[index];
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: _getButtonColor(btn),
                          elevation: 5,
                        ),
                        onPressed: () {
                          if (btn == '=') {
                            _hitung();
                          } else if (btn == 'C') {
                            _hapusSemua();
                          } else {
                            _tambahKarakter(btn);
                          }
                        },
                        child: Text(
                          btn,
                          style: TextStyle(
                            fontSize: 26, 
                            color: _getButtonTextColor(btn),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}