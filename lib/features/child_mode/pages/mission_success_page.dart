import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/star_paintar.dart' show StarPainter;

class MissionSuccessPage extends StatefulWidget {
  const MissionSuccessPage({Key? key}) : super(key: key);

  @override
  State<MissionSuccessPage> createState() => _MissionSuccessPageState();
}

class _MissionSuccessPageState extends State<MissionSuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  static const Color primaryThemeColor = Color(0xFF2C3E8C);
  static const Color buttonColor = Color(0xFFE2CEFF);
  static const Color textDarkColor = Color(0xFF3A3C9B);

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

                  // --- Gambar Maskot Lumi ---
                  Image.asset(
                    'assets/images/lumi.png',
                    height: 240,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 240,
                        width: 240,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Gambar Lumi\n(assets/images/lumi.png)",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // --- Teks Berhasil ---
                  const Text(
                    'Hore!\nKamu berhasil\nmenyelesaikan misimu',
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
                    'Waah, kamu bisa mendapatkan snack\ndari orang tuamu!',
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
                      foregroundColor: textDarkColor,
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
