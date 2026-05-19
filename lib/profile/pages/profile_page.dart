import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  final TextEditingController _namaController = TextEditingController(
    text: "Raizel",
  );
  final TextEditingController _tglLahirController = TextEditingController(
    text: "12 - 08 - 2015",
  );
  final TextEditingController _sandiController = TextEditingController(
    text: "********",
  );

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
    _namaController.dispose();
    _tglLahirController.dispose();
    _sandiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A3C9B), // Background warna solid
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
                          // --- Bagian Logo ---
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
                          const SizedBox(height: 20),

                          // --- Bagian Header (Tombol Back & Teks Profile) ---
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: _buildHeaderButton(
                                  icon: Icons.arrow_back_ios_new_rounded,
                                  onTap: () => Navigator.pop(context),
                                ),
                              ),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Garis tipis pembatas
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.white.withOpacity(0.4),
                          ),
                          const SizedBox(height: 30),

                          // --- Kartu 1: Info Profil User ---
                          _buildGlassCard(
                            child: Row(
                              children: [
                                // Foto Profil (Ganti path aset sesuai gambar Anda)
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/images/profile_pic.png',
                                      ), // TODO: Sesuaikan path foto profil
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Teks Profil
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello, Raizel',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Pengguna Utama Aplikasi',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // --- Kartu 2: Informasi Profile Anak ---
                          _buildGlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header Kartu 2
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Informasi Profile Anak',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Tombol Edit
                                    InkWell(
                                      onTap: () {
                                        // TODO: Aksi Edit Profil
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.edit_square,
                                          color: Color(0xFF3A3C9B),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // --- Form Input Data Anak ---
                                GlassTextField(
                                  label: 'Nama :',
                                  controller: _namaController,
                                ),
                                const SizedBox(height: 16),
                                GlassTextField(
                                  label: 'Tanggal Lahir :',
                                  controller: _tglLahirController,
                                ),
                                const SizedBox(height: 16),
                                GlassTextField(
                                  label: 'Sandi :',
                                  controller: _sandiController,
                                  isPassword: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
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
  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
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
}

// =========================================================================
// WIDGET KHUSUS: Form Input Glassmorphism (Sama seperti login)
// =========================================================================
class GlassTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  const GlassTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _borderOpacity;
  Offset? _pointerPosition;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _borderOpacity = Tween<double>(begin: 0.05, end: 0.6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = _focusNode.hasFocus;
    bool isHovered = _pointerPosition != null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: MouseRegion(
        onHover: (event) =>
            setState(() => _pointerPosition = event.localPosition),
        onExit: (event) => setState(() => _pointerPosition = null),
        child: Listener(
          onPointerMove: (event) =>
              setState(() => _pointerPosition = event.localPosition),
          onPointerDown: (event) =>
              setState(() => _pointerPosition = event.localPosition),
          onPointerUp: (event) => setState(() => _pointerPosition = null),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: isHovered || isFocused ? 15.0 : 10.0,
              sigmaY: isHovered || isFocused ? 15.0 : 10.0,
            ),
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  height:
                      80, // Dibuat sedikit lebih pendek agar muat cantik di dalam kartu
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(isFocused ? 0.12 : 0.08),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(
                        isFocused ? 0.8 : _borderOpacity.value,
                      ),
                      width: isFocused ? 1.5 : 1.2,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          if (_pointerPosition != null)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    center: FractionalOffset(
                                      _pointerPosition!.dx /
                                          constraints.maxWidth,
                                      _pointerPosition!.dy /
                                          constraints.maxHeight,
                                    ),
                                    radius: 2.0,
                                    colors: [
                                      Colors.white.withOpacity(0.35),
                                      Colors.white.withOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: TextField(
                                focusNode: _focusNode,
                                controller: widget.controller,
                                obscureText: widget.isPassword,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: widget.label,
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(
                                      isFocused || isHovered ? 1.0 : 0.6,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
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
