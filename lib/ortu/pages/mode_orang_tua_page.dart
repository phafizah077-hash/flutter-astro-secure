import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Import seluruh halaman yang dibutuhkan untuk navigasi
import 'laporan_kegiatan_page.dart';
import 'jadwal_kegiatan_page.dart';
import 'atur_screentime_page.dart';
import 'atur_reward_page.dart';

class ModeOrangTuaPage extends StatefulWidget {
  const ModeOrangTuaPage({Key? key}) : super(key: key);

  @override
  State<ModeOrangTuaPage> createState() => _ModeOrangTuaPageState();
}

class _ModeOrangTuaPageState extends State<ModeOrangTuaPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  static const Color primaryThemeColor = Color(0xFF2C3E8C);
  static const Color buttonColor = Color(0xFFE2CEFF);
  static const Color iconDarkColor = Color(0xFF3A3C9B);

  // Daftar menu sesuai tampilan desain
  final List<String> menus = [
    "Lihat Laporan Aktivitas Anak",
    "Atur Jadwal Aktivitas Anak",
    "Atur Durasi Screentime",
    "Atur Reward",
  ];

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
          // --- Animasi Bintang ---
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return CustomPaint(painter: StarPainter(_starController.value));
              },
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // --- Header ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: _buildHeaderButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
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
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // --- Judul & Garis Pembatas ---
                const Text(
                  'Mode Orang Tua',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 30),

                // --- Daftar Menu ---
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    physics: const BouncingScrollPhysics(),
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      return _buildMenuCard(menus[index], () {
                        // Logika Navigasi Berdasarkan Nama Menu
                        if (menus[index] == "Lihat Laporan Aktivitas Anak") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LaporanKegiatanPage(),
                            ),
                          );
                        } else if (menus[index] ==
                            "Atur Jadwal Aktivitas Anak") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JadwalKegiatanPage(),
                            ),
                          );
                        } else if (menus[index] == "Atur Durasi Screentime") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AturScreentimePage(),
                            ),
                          );
                        } else if (menus[index] == "Atur Reward") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AturRewardPage(),
                            ),
                          );
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tombol Header Kembali
  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: iconDarkColor, size: 24),
      ),
    );
  }

  // Card Menu Glassmorphism
  Widget _buildMenuCard(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12), // Warna semi transparan
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter Bintang Latar Belakang
class StarPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random(42);

  StarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;

    for (int i = 0; i < 65; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double baseSize = random.nextDouble() * 2.2;

      double opacity = (0.25 + (random.nextDouble() * 0.75)) * animationValue;
      double currentSize =
          baseSize * (0.6 + (random.nextDouble() * 0.4) * animationValue);

      paint.color = Colors.white.withOpacity(opacity.clamp(0.1, 1.0));
      canvas.drawCircle(
        Offset(x, y),
        currentSize,
        paint..style = PaintingStyle.fill,
      );

      if (i % 6 == 0) {
        double glowSize = currentSize * (2.5 + animationValue * 3.0);
        paint.strokeWidth = 0.4;
        canvas.drawLine(
          Offset(x - glowSize, y),
          Offset(x + glowSize, y),
          paint,
        );
        canvas.drawLine(
          Offset(x, y - glowSize),
          Offset(x, y + glowSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
