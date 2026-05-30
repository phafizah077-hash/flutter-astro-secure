import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/core/components/custom_button.dart';
import 'package:reminder_kelompok/core/components/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Menyamakan warna latar belakang dan panel dengan halaman Login
  static const Color primaryThemeColor = Color(0xFF2A2B7A);
  static const Color cardBackgroundColor = Color(0xFF353795);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
                                      'Daftar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Halo, Selamat datang..',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Isi datamu, untuk mulai mendampingi si\nkecil.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 35),

                                    // --- INPUT NAMA, EMAIL & SANDI ---
                                    CustomTextField(
                                      label: 'Nama :',
                                      controller: _nameController,
                                      keyboardType: TextInputType.name,
                                    ),
                                    const SizedBox(height: 20),
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
                                    const SizedBox(height: 35),

                                    // Spacer akan mendorong tombol ke bagian paling bawah form jika layar lebih tinggi
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
                                              // TODO: Tambahkan logika untuk daftar
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
