import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/core/components/custom_button.dart';

class VerifyAccountPage extends StatefulWidget {
  const VerifyAccountPage({Key? key}) : super(key: key);

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  // Menyamakan warna dengan halaman Auth lainnya
  static const Color primaryThemeColor = Color(0xFF2A2B7A);
  static const Color cardBackgroundColor = Color(0xFF353795);

  // Controllers dan FocusNodes untuk 4 kotak OTP
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
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
                                      'Verifikasi Akun',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Sudah mendapatkan kode?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Segera isi kode verifikasi yang tersedia.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 50),

                                    // --- FORM OTP KOTAK ---
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(4, (index) {
                                        return BaseOTPBox(
                                          controller: _otpControllers[index],
                                          focusNode: _otpFocusNodes[index],
                                          onChanged: (value) =>
                                              _onOtpChanged(value, index),
                                        );
                                      }),
                                    ),

                                    const Spacer(),
                                    const SizedBox(height: 40),

                                    // --- TOMBOL BAWAH ---
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
                                              // TODO: Logika validasi OTP
                                              // String otpCode = _otpControllers.map((e) => e.text).join();
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

// =========================================================================
// WIDGET KHUSUS: Kotak OTP Standar (Desain disamakan dengan CustomTextField)
// =========================================================================
class BaseOTPBox extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const BaseOTPBox({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<BaseOTPBox> createState() => _BaseOTPBoxState();
}

class _BaseOTPBoxState extends State<BaseOTPBox> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = widget.focusNode.hasFocus;

    // Menghitung lebar kotak secara dinamis agar pas 4 di layar
    double boxSize = (MediaQuery.of(context).size.width - 60 - (3 * 16)) / 4;
    // Maksimal kotak berukuran 65x65
    boxSize = boxSize > 65 ? 65 : boxSize;

    return Container(
      height: boxSize,
      width: boxSize,
      decoration: BoxDecoration(
        // Menyamakan warna latar belakang dengan CustomTextField (Solid White 20% / 25%)
        color: Colors.white.withOpacity(isFocused ? 0.25 : 0.20),
        // Menjaga radius melengkung tetap kotak melengkung 16px (bentuk tetap)
        borderRadius: BorderRadius.circular(16),
        // Menyamakan ketebalan (0.5) dan opacity garis tepi (75% / 100%) dengan CustomTextField
        border: Border.all(
          color: Colors.white.withOpacity(isFocused ? 1.0 : 0.75),
          width: 0.5,
        ),
      ),
      child: Center(
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          onChanged: widget.onChanged,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number, // Membuka numpad
          maxLength: 1, // Maksimal 1 angka per kotak
          style: const TextStyle(
            fontFamily: 'Nunito', // Menggunakan font Nunito agar seragam
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "", // Menyembunyikan teks counter karakter
            isDense: true,
          ),
        ),
      ),
    );
  }
}
