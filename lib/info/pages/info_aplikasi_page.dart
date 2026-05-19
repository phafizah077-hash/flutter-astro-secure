import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoAplikasiPage extends StatefulWidget {
  const InfoAplikasiPage({Key? key}) : super(key: key);

  @override
  State<InfoAplikasiPage> createState() => _InfoAplikasiPageState();
}

class _InfoAplikasiPageState extends State<InfoAplikasiPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  // Menyimpan index item yang sedang terbuka. Default: 0 (Item pertama terbuka langsung)
  int? _expandedIndex = 0;

  // Data konten untuk setiap menu dropdown info aplikasi
  final List<Map<String, String>> _menuData = [
    {
      'title': 'Perancang Astro.Secure',
      'content':
          'Astro.Secure merupakan aplikasi mobile yang dikembangkan oleh lima mahasiswi IDN Politeknik Bogor sebagai bagian dari proyek tugas akhir Semester 2.',
    },
    {
      'title': 'Baground Aplikasi', // Sesuai typo di desain gambar
      'content':
          'Astro.Secure dirancang berlatar belakang kebutuhan akan perlindungan privasi data pribadi dan peningkatan kesadaran keamanan digital di kalangan generasi muda yang kian krusial.',
    },
    {
      'title': 'Tujuan Aplikasi',
      'content':
          'Tujuan utama aplikasi ini adalah memberikan edukasi interaktif mengenai keamanan siber serta menyediakan alat bantu praktis untuk menjaga keamanan akun dan data sensitif pengguna.',
    },
    {
      'title': 'Beri Penilaian',
      'content':
          'Dukung pengembangan aplikasi kami dengan memberikan rating dan ulasan terbaik Anda di App Store atau Google Play Store untuk membantu kami terus berkembang.',
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
      backgroundColor: const Color(
        0xFF3A3C9B,
      ), // Background warna solid sesuai desain
      body: Stack(
        children: [
          // --- 1. Animasi Bintang ---
          AnimatedBuilder(
            animation: _starController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarPainter(_starController.value),
                child: Container(),
              );
            },
          ),

          // --- 2. Konten Utama ---
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // --- Bagian Header (Tombol Back & Logo) ---
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
                            ],
                          ),
                          const SizedBox(height: 24),

                          // --- Judul Halaman ---
                          const Text(
                            'Info Aplikasi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Garis tipis pembatas
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                          ),
                          const SizedBox(height: 30),

                          // --- Kartu Video Tutorial (Glassmorphism) ---
                          _buildGlassCard(
                            height: 320, // Tinggi kartu video tutorial
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Tutorial Penggunaan Aplikasi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Tombol Play Video Putih
                                InkWell(
                                  onTap: () {
                                    // TODO: Aksi putar video tutorial
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Color(
                                        0xFF3A3C9B,
                                      ), // Warna ikon biru/ungu
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),

                          // --- Teks Info Lebih Lengkap ---
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Info lebih lengkap\nmengenai aplikasi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1.3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // --- Daftar Tombol Menu Dropdown / Accordion ---
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _menuData.length,
                            itemBuilder: (context, index) {
                              final item = _menuData[index];
                              return _buildAccordionItem(
                                index: index,
                                title: item['title']!,
                                content: item['content']!,
                              );
                            },
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget Header Button (Kembali)
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
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF3A3C9B), size: 24),
      ),
    );
  }

  // Widget khusus pembungkus efek Kaca (Glassmorphism)
  Widget _buildGlassCard({required Widget child, required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // Widget Dropdown Accordion Item
  Widget _buildAccordionItem({
    required int index,
    required String title,
    required String content,
  }) {
    final bool isExpanded = _expandedIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          // --- Bagian Header Dropdown ---
          InkWell(
            onTap: () {
              setState(() {
                // Jika ditekan saat terbuka, maka tutup. Jika ditekan saat tertutup, buka item tersebut.
                _expandedIndex = isExpanded ? null : index;
              });
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFFE2CEFF), // Warna ungu muda terang
                // Mengatur borderRadius agar sudut bawah siku-siku ketika menu terbuka
                borderRadius: isExpanded
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )
                    : BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF3A3C9B),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Mengganti arah panah berdasarkan status expand menu
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.arrow_forward_ios_rounded,
                    color: const Color(0xFF3A3C9B),
                    size: isExpanded ? 24 : 16,
                  ),
                ],
              ),
            ),
          ),

          // --- Bagian Konten / Isi Dropdown (Muncul dengan Animasi Halus) ---
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: double.infinity,
              height: isExpanded ? null : 0, // Set height ke 0 agar tersembunyi
              decoration: const BoxDecoration(
                color: Colors.white, // Background putih solid
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: isExpanded
                  ? Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        content,
                        style: const TextStyle(
                          color: Color(
                            0xFF3A3C9B,
                          ), // Warna teks disesuaikan agar mudah dibaca
                          fontSize: 13,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// WIDGET KHUSUS: StarPainter (Animasi Bintang)
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
