import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelPage extends StatefulWidget {
  final String levelName;
  final int itemCount;

  // Constructor default untuk Level 1
  const LevelPage({
    Key? key,
    this.levelName = "Kegiatan Level 1",
    this.itemCount = 3,
  }) : super(key: key);

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage>
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
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.architecture_rounded,
                                  color: Colors.white,
                                  size: 42,
                                ),
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
                Text(
                  widget.levelName,
                  style: const TextStyle(
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
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.itemCount,
                    itemBuilder: (context, index) {
                      return _buildEditCard();
                    },
                  ),
                ),
                // Tombol Simpan di bagian bawah
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi Simpan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: iconDarkColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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

  // Card dengan ikon edit di sebelah kanan
  Widget _buildEditCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Isi Jadwal Kegiatan",
            style: TextStyle(
              color: Colors.white.withOpacity(
                0.6,
              ), // Teks pudar seperti placeholder
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Aksi saat ikon edit di klik
            },
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.edit_note_rounded, // Menggunakan ikon edit
                color: iconDarkColor,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
