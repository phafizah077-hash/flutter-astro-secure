import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/auth/verification/pages/verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  static const Color primaryThemeColor = Color(0xFF3A3C9B);
  static const Color buttonColor = Color(0xFFE2CEFF);

  final TextEditingController _emailController = TextEditingController();

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
    _emailController.dispose();
    super.dispose();
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

                            // --- TEKS SESUAI DESAIN LUPA SANDI ---
                            const Text(
                              'Lupa Sandi?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Kami akan membantu..',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight
                                    .bold, // Di desain terlihat lebih tebal
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Mohon, cantumkan emailmu untuk\nmendapatkan kode verifikasi.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // --- FORM INPUT EMAIL ---
                            GlassTextField(
                              label: 'Email :',
                              controller: _emailController,
                            ),

                            const Spacer(),
                            const SizedBox(height: 20),

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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const VerificationPage(),
                                        ),
                                      );
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
// WIDGET KHUSUS: Efek Garis Hilang-Timbul & Efek Kaca Mengikuti Cursor
// (Komponen ini disertakan kembali agar file bisa berjalan mandiri)
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
                  height: 85,
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
                              vertical: 18,
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
