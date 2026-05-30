import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/features/widgets/custom_back_button.dart';
import 'package:reminder_kelompok/features/widgets/glass_card.dart';

import '../../widgets/star_paintar.dart' show StarPainter;

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
                                width: 72,
                                height: 79,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // --- Bagian Header (Tombol Back & Teks Profile) ---
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: CustomBackButton(
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
                          GlassCard(
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
                          GlassCard(
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

                                // --- Form Input Data Anak (Tanpa Animasi, Solid Pastel) ---
                                SimpleProfileTextField(
                                  label: 'Nama:',
                                  controller: _namaController,
                                ),
                                const SizedBox(height: 16),
                                SimpleProfileTextField(
                                  label: 'Tanggal Lahir:',
                                  controller: _tglLahirController,
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
}

// =========================================================================
// WIDGET KHUSUS: Form Input Sederhana (Warna Solid, Tanpa Animasi)
// =========================================================================
class SimpleProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  const SimpleProfileTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE2CEFF), // Warna sama persis dengan tombol back
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Label teks kecil di atas
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF3A3C9B), // Warna teks ungu gelap agar terbaca
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          // TextField untuk inputannya
          TextField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(
              color: Color(0xFF3A3C9B), // Warna teks ungu gelap
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
