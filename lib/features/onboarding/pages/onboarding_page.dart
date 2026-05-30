import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/core/components/custom_button.dart';
import 'package:reminder_kelompok/features/auth/pages/login_page.dart';
import 'package:reminder_kelompok/features/auth/pages/register_page.dart';
import 'package:reminder_kelompok/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:reminder_kelompok/features/onboarding/bloc/onboarding_event.dart';
import 'package:reminder_kelompok/features/onboarding/bloc/onboarding_state.dart';
import 'package:reminder_kelompok/main.dart';

import '../../widgets/star_paintar.dart' show StarPainter;

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc(),
      child: const OnBoardingView(),
    );
  }
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _starController;

  // Variabel Warna (Sekarang background sama dengan buttonTextColor)
  static const Color buttonColor = Color(0xFFE2CEFF);
  static const Color primaryThemeColor = Color(
    0xFF3A3C9B,
  ); // Warna utama/background

  // Data onboarding dengan path gambar yang dibersihkan agar aman di semua platform (termasuk Flutter Web)
  final List<Map<String, String>> onboardingData = [
    {
      "title": "Ayo Mulai Menjelajah!",
      "subtitle":
          "Teman Ayah & Bunda untuk menemani\nsi kecil di dunia digital",
      "image": "assets/images/char_onboarding_1.png",
    },
    {
      "title": "Semangat Kerjakan Misi!",
      "subtitle": "Bantu jaga keseimbangan waktu layar\nanak",
      "image": "assets/images/char_onboarding_2.png",
    },
    {
      "title": "Kita mulai, Yuk!",
      "subtitle": "Dampingi anak dengan kebiasaan\ndigital yang lebih baik",
      "image": "assets/images/char_onboarding_3.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Mengubah animasi bintang agar kelap-kelip lembut bolak-balik (reverse) selama 3 detik
    // persis seperti yang diimplementasikan di Splash Screen
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _starController.dispose();
    super.dispose();
  }

  void _nextPage(int currentPage) {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    }
  }

  void _prevPage(int currentPage) {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryThemeColor, // Menggunakan warna 0xFF3A3C9B
      body: Stack(
        children: [
          // Background Bintang Bergerak (Bentuk Sparkle Bersudut 4 khas Splash Screen)
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
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      context.read<OnBoardingBloc>().add(PageChanged(index));
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo
                            SvgPicture.asset(
                              'assets/icons/logo.svg',
                              height: 79,
                              width: 72,
                              placeholderBuilder: (context) => const Icon(
                                Icons.rocket_launch_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Karakter (Menggunakan Image.asset dengan errorBuilder)
                            SizedBox(
                              height: 280,
                              child: Image.asset(
                                onboardingData[index]["image"]!,
                                fit: BoxFit.contain,
                                // errorBuilder dipanggil jika gambar gagal dimuat (misal path salah)
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 220,
                                      height: 220,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4A4DAB),
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Desain Roket Alternatif menggunakan Flutter Widget murni
                                          TweenAnimationBuilder<double>(
                                            tween: Tween(begin: 0, end: 2 * pi),
                                            duration: const Duration(
                                              seconds: 5,
                                            ),
                                            builder: (context, value, child) {
                                              return Transform.rotate(
                                                angle: -0.5,
                                                child: const Icon(
                                                  Icons.rocket_launch_rounded,
                                                  color: Color(0xFFE2CEFF),
                                                  size: 100,
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 15),
                                          const Text(
                                            "Gagal Memuat Gambar",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            // Title (Ag Title: 24px Bold)
                            Text(
                              onboardingData[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Subtitle (Ag Text 2: 16px)
                            Text(
                              onboardingData[index]["subtitle"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Indikator dan Tombol Navigasi
                BlocBuilder<OnBoardingBloc, OnBoardingState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
                      child: Column(
                        children: [
                          // Indikator Page
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              onboardingData.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                height: 4,
                                width: state.currentPage == index ? 32 : 16,
                                decoration: BoxDecoration(
                                  color: state.currentPage == index
                                      ? buttonColor
                                      : buttonColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Row Tombol yang menyesuaikan state halaman
                          _buildNavigationButtons(context, state.currentPage),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi khusus untuk memisahkan logika tata letak tombol per halaman
  Widget _buildNavigationButtons(BuildContext context, int currentPage) {
    if (currentPage == 0) {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: "Lanjut",
              backgroundColor: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () => _nextPage(currentPage),
            ),
          ),
        ],
      );
    } else if (currentPage == 1) {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: "Kembali",
              backgroundColor: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () => _prevPage(currentPage),
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: CustomButton(
              text: "Lanjut",
              backgroundColor: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () => _nextPage(currentPage),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: CustomButton(
              text: "Daftar",
              backgroundColor: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: CustomButton(
              text: "Masuk",
              backgroundColor: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
