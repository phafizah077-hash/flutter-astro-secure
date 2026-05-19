import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/info/pages/info_aplikasi_page.dart';
import 'package:reminder_kelompok/jadwal/pages/jadwal_kegiatan_page.dart';
import 'package:reminder_kelompok/ortu/pages/verfikasi_kode_page.dart';
import 'package:reminder_kelompok/profile/pages/profile_page.dart';
import 'package:reminder_kelompok/screentime/pages/screentime_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  @override
  void initState() {
    super.initState();
    // Menggunakan animasi bintang dari kode splash screen Anda
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
      body: Stack(
        children: [
          // 1. Background Gradasi sesuai kode Anda
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.17, 0.62, 0.96],
                colors: [
                  Color(0xFF3A3C9B), // 0%
                  Color(0xFF3A3C9B), // 17%
                  Color(0xFF7C5EBB), // 62%
                  Color(0xFFE3B0D1), // 96%
                ],
              ),
            ),
          ),

          // 2. Animasi Bintang (Custom Painter) dari kode Anda
          AnimatedBuilder(
            animation: _starController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarPainter(_starController.value),
                child: Container(),
              );
            },
          ),

          // 3. Konten Utama
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  // --- Bagian Header (Tombol Back, Logo, Tombol Menu) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tombol Back
                      _buildHeaderButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      // Bagian Logo Tengah
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logo.svg',
                            height: 42,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Astro.Secure',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      // Tombol Menu Titik Tiga dengan Dropdown
                      Theme(
                        data: Theme.of(context).copyWith(
                          popupMenuTheme: PopupMenuThemeData(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: PopupMenuButton<String>(
                          offset: const Offset(
                            0,
                            50,
                          ), // Memosisikan menu agak ke bawah agar tidak menutupi tombol
                          onSelected: (String value) {
                            if (value == 'Mode Orangtua') {
                              // --- NAVIGASI KE HALAMAN VERIFIKASI KODE ---
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const VerifikasiKodePage(),
                                ),
                              );
                            } else if (value == 'Profile') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfilePage(),
                                ),
                              );
                            } else if (value == 'Tentang Aplikasi') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const InfoAplikasiPage(),
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Mode Orangtua',
                                  child: Text(
                                    'Mode Orangtua',
                                    style: TextStyle(
                                      color: Color(
                                        0xFF3A3C9B,
                                      ), // Warna teks sesuai desain (Biru/Ungu Tua)
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Profile',
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                      color: Color(0xFF3A3C9B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Tentang Aplikasi',
                                  child: Text(
                                    'Tentang Aplikasi',
                                    style: TextStyle(
                                      color: Color(0xFF3A3C9B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                          // Tampilan tombol menggunakan desain yang sudah Anda punya
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.more_vert_rounded,
                              color: Color(0xFF3A3C9B),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // --- Bagian Teks Sapaan ---
                  const Text(
                    'Hello,Raizel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Garis tipis di bawah nama
                  Container(
                    width: 140,
                    height: 1,
                    color: Colors.white.withOpacity(0.5),
                  ),

                  const Spacer(flex: 1), // Fleksibel space
                  // --- Bagian Gambar Karakter / Maskot ---
                  // TODO: Ganti nama file ini dengan gambar PNG/SVG asli karakter Anda
                  Image.asset(
                    'assets/images/mascot.png', // Sesuaikan path jika berbeda
                    height: 250,
                    errorBuilder: (context, error, stackTrace) {
                      // Placeholder jika gambar belum ada
                      return const Icon(
                        Icons.image_not_supported,
                        size: 150,
                        color: Colors.white54,
                      );
                    },
                  ),

                  const Spacer(flex: 1), // Fleksibel space
                  // --- Bagian Tombol Menu (Jadwal & Screentime) ---
                  _buildGlassMenuButton(
                    title: 'Jadwal Kegiatan',
                    iconPath: 'assets/icons/calendar.svg',
                    defaultIcon: Icons.event_note_rounded,
                    onTap: () {
                      // Navigasi ke halaman Jadwal Kegiatan
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JadwalKegiatanPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildGlassMenuButton(
                    title: 'Screentime',
                    iconPath:
                        'assets/icons/stopwatch.svg', // Pakai icon SVG Anda
                    defaultIcon: Icons.timer_outlined,
                    onTap: () {
                      // Navigasi ke halaman Jadwal Kegiatan
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreentimePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget khusus untuk tombol Header (Back & More)
  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
            0.9,
          ), // Warna putih transparan seperti di gambar
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF3A3C9B), // Warna biru ungu
          size: 24,
        ),
      ),
    );
  }

  // Widget khusus untuk tombol menu utama dengan efek Glassmorphism
  Widget _buildGlassMenuButton({
    required String title,
    required String iconPath,
    required IconData defaultIcon,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Efek blur kaca
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // Transparan
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.6), // Garis putih
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                // Menggunakan SvgPicture jika ada, atau Icon biasa sebagai fallback
                Icon(defaultIcon, color: Colors.white, size: 32),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CustomPainter dari kode yang Anda berikan
class StarPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random(42);

  StarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;

    for (int i = 0; i < 70; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double baseSize = random.nextDouble() * 2.0;

      double opacity = (0.3 + (random.nextDouble() * 0.7)) * animationValue;
      double currentSize =
          baseSize * (0.5 + (random.nextDouble() * 0.5) * animationValue);

      paint.color = Colors.white.withOpacity(opacity.clamp(0.1, 1.0));

      canvas.drawCircle(
        Offset(x, y),
        currentSize,
        paint..style = PaintingStyle.fill,
      );

      // Efek kilau (cross) untuk bintang yang lebih besar
      if (i % 7 == 0) {
        double glowSize = currentSize * (2.0 + animationValue * 2.0);
        paint.strokeWidth = 0.2;
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
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
