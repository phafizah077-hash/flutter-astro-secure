import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/core/components/custom_button.dart';
import 'package:reminder_kelompok/core/components/custom_textfield.dart';
import 'package:reminder_kelompok/features/auth/pages/forgot_password_page.dart';
import 'package:reminder_kelompok/features/child_mode/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color primaryThemeColor = Color(
    0xFF2A2B7A,
  ); // Warna biru gelap latar belakang utama
  static const Color cardBackgroundColor = Color(
    0xFF353795,
  ); // Warna panel form

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryThemeColor,
      body: Stack(
        children: [
          // --- KONTEN UTAMA HALAMAN ---
          SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          // --- LOGO DI ATAS PANEL ---
                          Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/logo.svg',
                                  height: 56,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // --- PANEL FORM UTAMA ---
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: cardBackgroundColor.withOpacity(0.85),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(32),
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                  vertical: 35.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Masuk',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Selamat datang kembali..',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Isi datamu, untuk lanjut mendampingi si\nkecil.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 35),

                                    // --- INPUT EMAIL & SANDI ---
                                    CustomTextField(
                                      label: 'Email :',
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      label: 'Sandi :',
                                      controller: _passwordController,
                                      isPassword: true,
                                    ),

                                    // Spacer pertama: mendorong teks Lupa Sandi ke tengah
                                    const Spacer(),

                                    // --- LUPA SANDI (Sekarang berada di tengah-tengah area kosong) ---
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPasswordPage(),
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: const Text(
                                            'Lupa Sandi ?',
                                            style: TextStyle(
                                              fontFamily: 'Nunito',
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Spacer kedua: mendorong tombol navigasi tetap berada di dasar layar
                                    const Spacer(),

                                    // --- TOMBOL NAVIGASI ---
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            text: 'Kembali',
                                            backgroundColor: const Color(
                                              0xFFE2CEFF,
                                            ),
                                            textColor: const Color(0xFF3A3C9B),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomButton(
                                            text: 'Lanjut',
                                            backgroundColor: const Color(
                                              0xFFE2CEFF,
                                            ),
                                            textColor: const Color(0xFF3A3C9B),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
}
