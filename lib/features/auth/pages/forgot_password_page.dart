import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/core/components/custom_button.dart';
import 'package:reminder_kelompok/core/components/custom_textfield.dart';
import 'package:reminder_kelompok/features/auth/pages/verify_account_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Menyamakan warna latar belakang dan panel dengan halaman Login & Register
  static const Color primaryThemeColor = Color(0xFF2A2B7A);
  static const Color cardBackgroundColor = Color(0xFF353795);

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
                    // Menggunakan IntrinsicHeight agar panel mengisi sisa layar ke bawah
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
                                      'Lupa Sandi?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Kami akan membantu..',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Mohon, cantumkan emailmu untuk\nmendapatkan kode verifikasi.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 35),

                                    // --- FORM INPUT EMAIL ---
                                    CustomTextField(
                                      label: 'Email :',
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),

                                    const Spacer(),
                                    const SizedBox(height: 20),

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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const VerifyAccountPage(),
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
