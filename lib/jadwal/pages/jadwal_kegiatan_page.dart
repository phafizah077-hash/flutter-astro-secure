import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../gambar/pages/ambil_gambar_page.dart'; // Import halaman Ambil Gambar

class JadwalKegiatanPage extends StatefulWidget {
  const JadwalKegiatanPage({Key? key}) : super(key: key);

  @override
  State<JadwalKegiatanPage> createState() => _JadwalKegiatanPageState();
}

class _JadwalKegiatanPageState extends State<JadwalKegiatanPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  // Warna latar belakang biru malam stellar sesuai gambar referensi
  static const Color primaryThemeColor = Color(0xFF2C3E8C);
  static const Color buttonColor = Color(0xFFE2CEFF);
  static const Color iconDarkColor = Color(0xFF3A3C9B);

  // Daftar data kegiatan asli (Jika ingin melihat tampilan kosong, Anda cukup mengosongkan list ini menjadi [])
  final List<Map<String, dynamic>> _kegiatanList = [
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": false,
    },
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": false,
    },
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": true,
    },
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": true,
    },
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
                // --- Header & Judul ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header (Tombol Back & Logo Astro.Secure)
                      Stack(
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
                      const SizedBox(height: 30),

                      // Judul Halaman
                      const Center(
                        child: Text(
                          'Kegiatanmu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Garis tipis pembatas
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),

                // --- Daftar Kegiatan ATAU Tampilan Kosong ---
                Expanded(
                  child: _kegiatanList.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Oh,no..',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Belum ada jadwal kegiatan\nyang tersedia',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                    fontSize: 16,
                                    height: 1.4,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 10.0,
                          ),
                          itemCount: _kegiatanList.length,
                          itemBuilder: (context, index) {
                            final item = _kegiatanList[index];
                            return _buildJadwalCard(
                              title: item["title"],
                              time: item["time"],
                              isDone: item["isDone"],
                              onToggle: () {
                                setState(() {
                                  _kegiatanList[index]["isDone"] =
                                      !_kegiatanList[index]["isDone"];
                                });
                              },
                            );
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

  // Widget Header Button (Kembali) dengan latar belakang soft-transparan melengkung
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
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // Widget untuk Kartu Jadwal Kegiatan (Mendukung State Sebelum & Sesudah Ambil Foto)
  Widget _buildJadwalCard({
    required String title,
    required String time,
    required bool isDone,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Opacity(
        // Jika sudah selesai (isDone), card dibuat sedikit pudar (faded) sesuai gambar kanan
        opacity: isDone ? 0.55 : 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                // Card transparan glassmorphism violet-blue
                color: isDone
                    ? Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDone
                      ? Colors.white.withOpacity(0.15)
                      : Colors.white.withOpacity(0.35),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  // --- 1. Teks Judul & Detail Waktu Kegiatan ---
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: isDone
                                ? FontWeight.normal
                                : FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          time,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // --- 2. Tombol Aksi di Sebelah Kanan (Kamera atau Centang) ---
                  GestureDetector(
                    onTap: () async {
                      if (!isDone) {
                        // Menuju halaman pengambilan gambar baru
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AmbilGambarPage(kegiatanTitle: title),
                          ),
                        );
                        // Jika berhasil mengumpulkan foto, ganti status kegiatan menjadi selesai
                        if (result == true) {
                          onToggle();
                        }
                      } else {
                        // Jika ingin membatalkan centang (opsional untuk mempermudah testing)
                        onToggle();
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: isDone
                            ? Colors.white.withOpacity(
                                0.1,
                              ) // Tombol redup transparan jika selesai
                            : buttonColor, // Tombol ungu pastel terang jika aktif
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDone
                              ? Colors.white.withOpacity(0.2)
                              : Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: Icon(
                        isDone ? Icons.check_rounded : Icons.camera_alt_rounded,
                        color: isDone
                            ? Colors.white.withOpacity(0.8)
                            : iconDarkColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// WIDGET KHUSUS: StarPainter (Animasi Bintang Indah)
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
