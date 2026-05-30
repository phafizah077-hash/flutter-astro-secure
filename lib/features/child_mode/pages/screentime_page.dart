import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/core/components/custom_button.dart';
import 'package:reminder_kelompok/features/child_mode/pages/journey_page.dart';

import '../../widgets/star_paintar.dart' show StarPainter;

class ScreentimePage extends StatefulWidget {
  const ScreentimePage({Key? key}) : super(key: key);

  @override
  State<ScreentimePage> createState() => _ScreentimePageState();
}

class _ScreentimePageState extends State<ScreentimePage>
    with TickerProviderStateMixin {
  late AnimationController _starController;
  late AnimationController _glowController;

  // Warna utama sesuai dengan desain Astro.Secure
  static const Color primaryBgColor = Color(0xFF3A3C9B); // Latar belakang luar
  static const Color accentPurple = Color(
    0xFFE2CEFF,
  ); // Tombol & Back lavender pastel
  static const Color darkTextPurple = Color(
    0xFF3A3C9B,
  ); // Warna teks/ikon ungu gelap

  @override
  void initState() {
    super.initState();
    // Animasi kelap-kelip bintang
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Animasi glow berdenyut lembut pada lingkaran screentime
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _starController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: Stack(
        children: [
          // --- 1. Animasi Bintang Latar Belakang ---
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return CustomPaint(painter: StarPainter(_starController.value));
              },
            ),
          ),

          // --- 2. Konten Utama ---
          SafeArea(
            child: Column(
              children: [
                // --- Bagian Header ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Tombol Kembali di Kiri Atas (Sesuai Desain Bulat Lavender)
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: accentPurple,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: darkTextPurple,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      // Logo Astro.Secure di Tengah
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logo.svg',
                            width: 72,
                            height: 79,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.polyline_rounded,
                                color: Colors.white,
                                size: 42,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // --- Teks Judul Utama ---
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Penggunaan Durasi\nScreentime',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),

                const Spacer(),

                // --- 3. Cincin Indikator Durasi (Timer Ring) ---
                AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, child) {
                    return Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // Efek ring luar transparan berpendar
                        border: Border.all(
                          color: Colors.white.withOpacity(
                            0.12 + (_glowController.value * 0.08),
                          ),
                          width: 24,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(
                              0.02 + (_glowController.value * 0.03),
                            ),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 172,
                        width: 172,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // Efek gradasi kaca bagian dalam
                          color: Colors.white.withOpacity(0.04),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '00:00:00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const Spacer(),

                // --- 4. Tombol Utama (Pill Button di Bagian Bawah - Sesuai gambar terbaru) ---
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                    vertical: 40.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Lihat Perjalanan',
                      backgroundColor: accentPurple,
                      textColor: primaryBgColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JourneyPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
