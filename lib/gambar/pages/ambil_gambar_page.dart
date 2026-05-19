import 'dart:math';
import 'package:flutter/material.dart';

class AmbilGambarPage extends StatefulWidget {
  final String kegiatanTitle;

  const AmbilGambarPage({Key? key, required this.kegiatanTitle})
    : super(key: key);

  @override
  State<AmbilGambarPage> createState() => _AmbilGambarPageState();
}

class _AmbilGambarPageState extends State<AmbilGambarPage> {
  // State untuk melacak apakah foto sudah diambil atau belum
  bool _hasCaptured = false;

  // Warna tema sesuai dengan desain Astro.Secure
  static const Color primaryBgColor = Color(0xFF2C3E8C); // Latar belakang luar
  static const Color viewfinderBgColor = Color(
    0xFF1B1D4B,
  ); // Latar belakang kamera hitam-biru gelap
  static const Color accentPurple = Color(
    0xFFE2CEFF,
  ); // Warna ungu pastel tombol
  static const Color darkTextPurple = Color(
    0xFF3A3C9B,
  ); // Warna teks/ikon ungu gelap

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- 1. AREA KAMERA / VIEWFINDER (Melengkung Indah) ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: viewfinderBgColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    children: [
                      // Tombol Kembali (Back Button) di Kiri Atas
                      Positioned(
                        top: 20,
                        left: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: accentPurple,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: darkTextPurple,
                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      // Bingkai Fokus Bidik (Viewfinder Focus) di Tengah
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Custom Paint atau Container untuk menggambar sudut bingkai fokus kamera
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Stack(
                                children: [
                                  // Ikon Kamera di Tengah Bingkai Fokus
                                  Center(
                                    child: Icon(
                                      _hasCaptured
                                          ? Icons.camera_rounded
                                          : Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                                  ),
                                  // Efek sudut fokus (opsional untuk mempercantik)
                                  ..._buildFocusCorners(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- 2. PANEL TOMBOL DI BAGIAN BAWAH ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 24.0,
              ),
              color: primaryBgColor,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: !_hasCaptured
                    ? _buildCapturePanel() // Tampilan Shutter Kamera
                    : _buildActionPanel(), // Tampilan Ulangi & Kumpulkan
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget panel tombol saat mengambil gambar
  Widget _buildCapturePanel() {
    return Center(
      key: const ValueKey('capture_mode'),
      child: GestureDetector(
        onTap: () {
          // Mengubah state menjadi sudah mengambil gambar (mock capture)
          setState(() {
            _hasCaptured = true;
          });
        },
        child: Container(
          height: 64,
          width: 64,
          decoration: const BoxDecoration(
            color: accentPurple,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt_rounded,
            color: darkTextPurple,
            size: 24,
          ),
        ),
      ),
    );
  }

  // Widget panel tombol sesudah mengambil gambar (Ulangi & Kumpulkan)
  Widget _buildActionPanel() {
    return Row(
      key: const ValueKey('action_mode'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Tombol Ulangi (Retake)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Mengembalikan ke mode mengambil gambar kembali
                setState(() {
                  _hasCaptured = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentPurple,
                foregroundColor: darkTextPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Ulangi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),

        // Tombol Kumpulkan (Submit)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Mengembalikan nilai 'true' untuk menandakan kegiatan berhasil diselesaikan
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentPurple,
                foregroundColor: darkTextPurple,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Kumpulkan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Membuat dekorasi sudut fokus kamera putih agar mirip dengan gambar referensi
  List<Widget> _buildFocusCorners() {
    const double cornerLength = 16.0;
    const double cornerThickness = 4.0;
    const Color cornerColor = Colors.white;

    return [
      // Kiri Atas
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: cornerColor,
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: cornerColor,
        ),
      ),
      // Kanan Atas
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: cornerColor,
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: cornerColor,
        ),
      ),
      // Kiri Bawah
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: cornerColor,
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: cornerColor,
        ),
      ),
      // Kanan Bawah
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: cornerLength,
          height: cornerThickness,
          color: cornerColor,
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: cornerThickness,
          height: cornerLength,
          color: cornerColor,
        ),
      ),
    ];
  }
}
