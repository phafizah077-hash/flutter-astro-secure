import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/star_paintar.dart' show StarPainter;

class MissionFailedPage extends StatefulWidget {
  const MissionFailedPage({Key? key}) : super(key: key);

  @override
  State<MissionFailedPage> createState() => _MissionFailedPageState();
}

class _MissionFailedPageState extends State<MissionFailedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  static const Color primaryThemeColor = Color(0xFF2C3E8C);
  static const Color buttonColor = Color(0xFFE2CEFF);
  static const Color iconDarkColor = Color(0xFF3A3C9B);

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryThemeColor,
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
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // --- Header Logo ---
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logo.svg',
                        height: 42,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.architecture_rounded,
                            color: Colors.white,
                            size: 42,
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Astro.Secure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // --- Ikon Silang Besar (Gagal) ---
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: buttonColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close_rounded,
                        size: 140,
                        color: iconDarkColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // --- Teks Gagal ---
                  const Text(
                    'Aduh...\nKamu gagal menyelesaikan\nmisimu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Jangan Menyerah, ayo perbaiki misimu\nyang gagal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(flex: 3),

                  // --- Tombol Kembali ---
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: iconDarkColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
