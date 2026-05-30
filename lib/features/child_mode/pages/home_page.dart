import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/features/profile/pages/about_app_page.dart';
import 'package:reminder_kelompok/features/child_mode/pages/schedule_page.dart';
import 'package:reminder_kelompok/features/parent_mode/pages/pin_verification_page.dart';
import 'package:reminder_kelompok/features/profile/pages/profile_page.dart';
import 'package:reminder_kelompok/features/child_mode/pages/screentime_page.dart';
import 'package:reminder_kelompok/features/widgets/custom_back_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _starController;
  late AnimationController _characterScaleController;

  @override
  void initState() {
    super.initState();
    // Menggunakan animasi bintang dari kode splash screen Anda dengan durasi 3 detik bolak-balik
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Animasi skala untuk efek memantul lembut saat karakter ditekan
    _characterScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _starController.dispose();
    _characterScaleController.dispose();
    super.dispose();
  }

  // Aksi ketika karakter ditekan
  void _onCharacterTap() {
    _characterScaleController.reverse().then((_) {
      _characterScaleController.forward().then((_) {
        // --- NAVIGASI KE HALAMAN YANG DIINGINKAN ---
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SchedulePage()),
        );
      });
    });
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

          // 2. Animasi Bintang (Custom Painter) yang sudah disamakan
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Tombol Back dengan warna pastel figma
                      CustomBackButton(onTap: () => Navigator.pop(context)),

                      // Bagian Logo Tengah (Dimensi Bounding Box Figma: 72x79)
                      SvgPicture.asset(
                        'assets/icons/logo.svg',
                        width: 72,
                        height: 79,
                        fit: BoxFit.contain,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PinVerificationPage(),
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
                                  builder: (context) => const AboutAppPage(),
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
                          // Tampilan tombol menggunakan desain figma
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFE2CEFF,
                              ), // Latar belakang ungu muda figma
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.more_vert_rounded,
                              color: Color(0xFF3A3C9B), // Ikon ungu tua figma
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // --- Bagian Teks Sapaan (Garis hanya di bawah) ---
                  Container(
                    width: 193,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      // Hanya menampilkan border di bagian bawah saja
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFD5B9FF), // Stroke warna #D5B9FF
                          width: 1.0, // Weight 1
                        ),
                      ),
                    ),
                    child: const Text(
                      'Hello,Raizel',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const Spacer(flex: 1), // Fleksibel space
                  // --- Bagian Gambar Karakter / Maskot Interaktif ---
                  GestureDetector(
                    onTap: _onCharacterTap,
                    child: AnimatedBuilder(
                      animation: _characterScaleController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _characterScaleController.value,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/images/homepage karakter lumi.png',
                        width: 288, // Dimensi lebar Figma 287.91
                        height: 339, // Dimensi tinggi Figma 339
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 150,
                            color: Colors.white54,
                          );
                        },
                      ),
                    ),
                  ),

                  const Spacer(flex: 1), // Fleksibel space
                  // --- Bagian Tombol Menu (Jadwal & Screentime dengan Gambar PNG) ---
                  _buildGlassMenuButton(
                    title: 'Jadwal Kegiatan',
                    imagePath:
                        'assets/icons/icon_atur_jadwal.png', // Sudah menggunakan spasi yang dihapus
                    defaultIcon: Icons.event_note_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SchedulePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32), // Jarak antar tombol
                  _buildGlassMenuButton(
                    title: 'Screentime',
                    imagePath:
                        'assets/icons/icon_waktu_screentime.png', // Sudah menggunakan spasi yang dihapus
                    defaultIcon: Icons.timer_outlined,
                    onTap: () {
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

  // Widget khusus untuk tombol menu utama dengan efek Glassmorphism
  Widget _buildGlassMenuButton({
    required String title,
    required String imagePath,
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
            width: 253, // Mengikuti lebar Figma
            height: 67, // Mengikuti tinggi Figma
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2), // Transparansi putih halus
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD5B9FF).withOpacity(
                  0.4,
                ), // Menggunakan warna stroke figma lavender halus
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(defaultIcon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// WIDGET KHUSUS: Mengadaptasi StarPainter dari Splash Screen (Murni Kelap-Kelip)
// =========================================================================
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

      double baseSize = 3.0 + (random.nextDouble() * 6.0);
      double opacity = (0.3 + (random.nextDouble() * 0.7)) * animationValue;
      double currentSize =
          baseSize * (0.6 + (random.nextDouble() * 0.4) * animationValue);

      paint.color = Colors.white.withOpacity(opacity.clamp(0.1, 1.0));

      Path starPath = Path();
      starPath.moveTo(x, y - currentSize);

      starPath.quadraticBezierTo(x, y, x + currentSize, y);
      starPath.quadraticBezierTo(x, y, x, y + currentSize);
      starPath.quadraticBezierTo(x, y, x - currentSize, y);
      starPath.quadraticBezierTo(x, y, x, y - currentSize);

      canvas.drawPath(starPath, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
