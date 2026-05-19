import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/auth/login/pages/login_page.dart';
import 'package:reminder_kelompok/auth/register/pages/register_page.dart';
import 'package:reminder_kelompok/intro/onboarding/bloc/onboarding_bloc.dart';
import 'package:reminder_kelompok/intro/onboarding/bloc/onboarding_event.dart';
import 'package:reminder_kelompok/intro/onboarding/bloc/onboarding_state.dart';
import 'package:reminder_kelompok/main.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc(),
      child: const OnBoardingView(),
    );
  }
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

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

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Ayo Mulai Menjelajah!",
      "subtitle":
          "Teman Ayah & Bunda untuk menemani\nsi kecil di dunia digital",
      "image": "assets/images/shar_onboarding.svg",
    },
    {
      "title": "Semangat Kerjakan Misi!",
      "subtitle": "Bantu jaga keseimbangan waktu layar\nanak",
      "image": "assets/images/shar_onboarding.svg",
    },
    {
      "title": "Kita mulai, Yuk!",
      "subtitle": "Dampingi anak dengan kebiasaan\ndigital yang lebih baik",
      "image": "assets/images/shar_onboarding.svg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
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
      // Pastikan DashboardPage tersedia di main.dart atau diimport
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
          // Background Bintang Bergerak
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
                            ),
                            const SizedBox(height: 30),
                            // Karakter
                            SizedBox(
                              height: 280,
                              child: SvgPicture.asset(
                                onboardingData[index]["image"]!,
                                fit: BoxFit.contain,
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
      // Halaman 1: Hanya tombol Lanjut di tengah (lebar penuh)
      return Row(
        children: [
          Expanded(
            child: _buildButton(
              text: "Lanjut",
              color: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () => _nextPage(currentPage),
              isVisible: true,
            ),
          ),
        ],
      );
    } else if (currentPage == 1) {
      // Halaman 2: Tombol Kembali (Kiri) dan Lanjut (Kanan)
      return Row(
        children: [
          Expanded(
            child: _buildButton(
              text: "Kembali",
              color: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () => _prevPage(currentPage),
              isVisible: true,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton(
              text: "Lanjut",
              color: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () => _nextPage(currentPage),
              isVisible: true,
            ),
          ),
        ],
      );
    } else {
      // Halaman 3: Tombol Masuk (Kiri) dan Daftar (Kanan)
      return Row(
        children: [
          Expanded(
            child: _buildButton(
              text: "Daftar",
              color: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              isVisible: true,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton(
              text: "Masuk",
              color: buttonColor,
              textColor: primaryThemeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              isVisible: true,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    required bool isVisible,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isVisible ? 1.0 : 0.0,
      child: IgnorePointer(
        ignoring: !isVisible,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class StarPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random(123);

  StarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 60; i++) {
      double x = (random.nextDouble() * size.width);
      double y = (random.nextDouble() * size.height);
      double movingY = (y + (animationValue * 30)) % size.height;
      double starSize = random.nextDouble() * 1.8;
      double opacity = 0.2 + (0.8 * sin(animationValue * 2 * pi + i));

      final paint = Paint()
        ..color = Colors.white.withOpacity(opacity.clamp(0.0, 1.0));
      canvas.drawCircle(Offset(x, movingY), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) => true;
}
