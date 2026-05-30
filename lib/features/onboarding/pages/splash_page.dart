import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/features/onboarding/pages/onboarding_page.dart';

import '../../widgets/star_paintar.dart' show StarPainter;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Controller untuk animasi bintang berkelap-kelip
    // Durasi dibuat sedikit lebih lambat agar transisinya halus
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Navigasi otomatis ke Onboarding setelah 4 detik
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradasi dengan 4 titik warna sesuai desain Figma
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

          // 2. Animasi Bintang (Custom Painter)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: StarPainter(_controller.value),
                child: Container(),
              );
            },
          ),

          // 3. Logo dan Nama Aplikasi
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo.svg',
                      height: 116,
                      width: 122,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      placeholderBuilder: (BuildContext context) => const Icon(
                        Icons.change_history_rounded,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
