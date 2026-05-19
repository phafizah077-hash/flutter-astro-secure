import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PerjalananAnakPage extends StatefulWidget {
  const PerjalananAnakPage({Key? key}) : super(key: key);

  @override
  State<PerjalananAnakPage> createState() => _PerjalananAnakPageState();
}

class _PerjalananAnakPageState extends State<PerjalananAnakPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  // Tema warna kosmik Astro.Secure
  static const Color primaryBgColor = Color(0xFF2C3E8C); // Latar belakang luar
  static const Color accentPurple = Color(0xFFE2CEFF); // Lavender pastel terang
  static const Color darkTextPurple = Color(0xFF3A3C9B); // Teks/Ikon ungu gelap

  @override
  void initState() {
    super.initState();
    // Animasi kelap-kelip bintang latar belakang
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // --- Bagian Header ---
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // Tombol Kembali di Kiri Atas
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
                              height: 42,
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

                  // --- Teks Judul Utama ---
                  const Center(
                    child: Text(
                      'Perjalanan Anak',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Garis pembatas tipis
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- 3. Ringkasan Status Mingguan (Senin - Minggu) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildWeeklyStatusCard(),
                  ),

                  const SizedBox(height: 16),

                  // --- 4. Card "Hari Berhasil" ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildInfoCard(
                      icon: Icons.star_rounded,
                      title: 'Hari Berhasil',
                      description:
                          '5 dari 7 hari berhasil menyelesaikan misi minggu ini',
                      iconColor: accentPurple,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- 5. Card "Hari Belum Berhasil" ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildInfoCard(
                      icon: Icons.cancel_rounded,
                      title: 'Hari Belum Berhasil',
                      description:
                          '2 hari berhasil menyelesaikan misi minggu ini',
                      iconColor: accentPurple.withOpacity(0.8),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- 6. Card "Lumi" dengan Progress Bar ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildLumiProgressCard(),
                  ),

                  const SizedBox(height: 40), // Ruang ekstra di bawah scroll
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Baris Ringkasan Hari (Senin - Minggu)
  Widget _buildWeeklyStatusCard() {
    final List<Map<String, dynamic>> days = [
      {"name": "Senin", "isSuccess": true},
      {"name": "Selasa", "isSuccess": false},
      {"name": "Rabu", "isSuccess": true},
      {"name": "Kamis", "isSuccess": true},
      {"name": "Jumat", "isSuccess": true},
      {"name": "Sabtu", "isSuccess": false},
      {"name": "Minggu", "isSuccess": true},
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days.map((day) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ikon representasi status hari (Bintang = Berhasil, Silang = Belum Berhasil)
                  Icon(
                    day["isSuccess"]
                        ? Icons.star_rounded
                        : Icons.cancel_rounded,
                    color: accentPurple,
                    size: 32,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    day["name"],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Widget template umum untuk Card Informasi
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color iconColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ikon Utama di kiri
              Icon(icon, color: iconColor, size: 36),
              const SizedBox(width: 16),
              // Detail Teks informasi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget khusus untuk Card Kemajuan Lumi
  Widget _buildLumiProgressCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Ikon Planet Bercincin merepresentasikan "Lumi" luar angkasa
                  const Icon(
                    Icons.blur_circular_rounded, // Visualisasi planet
                    color: accentPurple,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Lumi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '21 / 28 misi selesai',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 12),
              // Progress Bar tebal melengkung indah sesuai gambar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 18,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.15),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 21 / 28, // Progres 75%
                    child: Container(
                      decoration: BoxDecoration(
                        color: accentPurple.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                '7 misi lagi menuju Terra',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// WIDGET KHUSUS: StarPainter (Animasi Bintang Kosmik Stellar)
// =========================================================================
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

      // Gambar bintang bulat kecil
      canvas.drawCircle(
        Offset(x, y),
        currentSize,
        paint..style = PaintingStyle.fill,
      );

      // Gambar pancaran garis cahaya bintang 4-sudut (seperti tanda tambah halus)
      if (i % 6 == 0) {
        double glowSize = currentSize * (2.5 + animationValue * 3.0);
        paint.strokeWidth = 0.4;

        // Garis horizontal
        canvas.drawLine(
          Offset(x - glowSize, y),
          Offset(x + glowSize, y),
          paint,
        );
        // Garis vertikal
        canvas.drawLine(
          Offset(x, y - glowSize),
          Offset(x, y + glowSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
