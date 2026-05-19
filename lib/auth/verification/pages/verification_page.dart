import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with SingleTickerProviderStateMixin {
  static const Color primaryThemeColor = Color(0xFF3A3C9B);
  static const Color buttonColor = Color(0xFFE2CEFF);

  // Controllers dan FocusNodes untuk 4 kotak OTP
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Fungsi untuk mengatur perpindahan fokus antar kotak OTP
  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Pindah ke kotak berikutnya jika diisi
      if (index < 3) {
        FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
      } else {
        // Otomatis menutup keyboard jika kotak terakhir diisi
        _otpFocusNodes[index].unfocus();
      }
    } else {
      // Pindah ke kotak sebelumnya jika dihapus
      if (index > 0) {
        FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryThemeColor,
      body: Stack(
        children: [
          // --- EFEK ANIMASI AURORA ---
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment(
                      cos(_bgController.value * 2 * pi),
                      sin(_bgController.value * 2 * pi),
                    ),
                    child: Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF6A6CBF).withOpacity(0.7),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(
                      -cos(_bgController.value * 2 * pi),
                      -sin(_bgController.value * 2 * pi),
                    ),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE2CEFF).withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),

          // --- KONTEN UTAMA HALAMAN ---
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Center(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/logo.svg',
                                    height: 48,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Astro.Secure',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            Divider(
                              color: Colors.white.withOpacity(0.4),
                              thickness: 1,
                            ),
                            const SizedBox(height: 30),

                            // --- TEKS JUDUL (VERIFIKASI AKUN) ---
                            const Text(
                              'Verifikasi Akun',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Sudah mendapatkan kode?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Segera isi kode verifikasi yang tersedia.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 50),

                            // --- FORM OTP KOTAK (GLASSMORPHISM) ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(4, (index) {
                                return GlassOTPBox(
                                  controller: _otpControllers[index],
                                  focusNode: _otpFocusNodes[index],
                                  onChanged: (value) =>
                                      _onOtpChanged(value, index),
                                );
                              }),
                            ),

                            // Spacer mendorong tombol ke dasar layar
                            const Spacer(),
                            const SizedBox(height: 40),

                            // --- TOMBOL BAWAH ---
                            Row(
                              children: [
                                Expanded(
                                  child: _buildButton(
                                    text: 'Kembali',
                                    color: buttonColor,
                                    textColor: primaryThemeColor,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildButton(
                                    text: 'Lanjut',
                                    color: buttonColor,
                                    textColor: primaryThemeColor,
                                    onPressed: () {
                                      // TODO: Logika validasi OTP
                                      // Contoh ambil nilai OTP:
                                      // String otpCode = _otpControllers.map((e) => e.text).join();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
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

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

// =========================================================================
// WIDGET KHUSUS: Kotak OTP dengan Efek Kaca & Border Animasi Hilang-Timbul
// =========================================================================
class GlassOTPBox extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const GlassOTPBox({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<GlassOTPBox> createState() => _GlassOTPBoxState();
}

class _GlassOTPBoxState extends State<GlassOTPBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _borderOpacity;

  Offset? _pointerPosition;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = widget.focusNode.hasFocus;
    bool isHovered = _pointerPosition != null;

    // Menghitung lebar kotak secara dinamis agar pas 4 di layar
    double boxSize = (MediaQuery.of(context).size.width - 60 - (3 * 16)) / 4;
    // Maksimal kotak berukuran 65x65
    boxSize = boxSize > 65 ? 65 : boxSize;

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        16,
      ), // Radius lebih kecil dari form teks biasa
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
                  height: boxSize,
                  width: boxSize,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(isFocused ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(
                        isFocused ? 0.8 : _borderOpacity.value,
                      ),
                      width: isFocused ? 1.5 : 1.2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Efek Cahaya / Spotlight kursor
                      if (_pointerPosition != null)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: FractionalOffset(
                                  _pointerPosition!.dx / boxSize,
                                  _pointerPosition!.dy / boxSize,
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
                      // Input TextField diletakkan pas ditengah
                      Center(
                        child: TextField(
                          focusNode: widget.focusNode,
                          controller: widget.controller,
                          onChanged: widget.onChanged,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number, // Membuka numpad
                          maxLength: 1, // Maksimal 1 angka per kotak
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText:
                                "", // Menyembunyikan teks counter karakter
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
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
