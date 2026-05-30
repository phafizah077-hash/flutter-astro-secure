import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reminder_kelompok/core/components/custom_card.dart'; // Import CustomCard
import 'package:image_picker/image_picker.dart';
import 'package:reminder_kelompok/features/widgets/custom_back_button.dart';

import '../../widgets/star_paintar.dart'
    show StarPainter; // Tambahkan import image_picker

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _starController;

  // Warna latar belakang biru malam stellar sesuai gambar referensi
  static const Color primaryThemeColor = Color(0xFF3A3C9B);
  static const Color buttonColor = Color(0xFFE2CEFF);
  static const Color iconDarkColor = Color(0xFF3A3C9B);

  // Daftar data kegiatan asli
  final List<Map<String, dynamic>> _kegiatanList = [
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": false,
    },
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": false,
    },
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": true,
    },
    {
      "title": "Membersihkan Lemari Pakaian Sendiri",
      "time": "Time : 1 Hours",
      "isDone": true,
    },
  ];

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryThemeColor,
      body: Stack(
        children: [
          // --- 1. Animasi Bintang Latar Belakang ---
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _starController,
              builder: (context, child) {
                return CustomPaint(painter: StarPainter(_starController.value));
              },
            ),
          ),

          // --- 2. Konten Utama ---
          SafeArea(
            child: Column(
              children: [
                // --- Header & Judul ---
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header (Tombol Back & Logo Astro.Secure)
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomBackButton(
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
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
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.polyline_rounded,
                                    color: Colors.white,
                                    size: 42,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Judul Halaman
                      const Center(
                        child: Text(
                          'Kegiatanmu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Garis tipis pembatas
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),

                // --- Daftar Kegiatan ATAU Tampilan Kosong ---
                Expanded(
                  child: _kegiatanList.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Oh,no..',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Belum ada jadwal kegiatan\nyang tersedia',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.75),
                                    fontSize: 16,
                                    height: 1.4,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 10.0,
                          ),
                          itemCount: _kegiatanList.length,
                          itemBuilder: (context, index) {
                            final item = _kegiatanList[index];
                            // Menggunakan CustomCard yang sudah dibuat
                            return CustomCard(
                              title: item["title"],
                              time: item["time"],
                              isDone: item["isDone"],
                              actionButtonColor: buttonColor,
                              actionIconColor: iconDarkColor,
                              onActionTap: () async {
                                if (!item["isDone"]) {
                                  // Menginisialisasi image_picker untuk membuka Kamera HP
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? photo = await picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality:
                                        80, // Opsional: mengompres ukuran foto
                                  );

                                  // Jika user berhasil mengambil foto (photo tidak null)
                                  if (photo != null) {
                                    setState(() {
                                      _kegiatanList[index]["isDone"] = true;
                                    });
                                    // Catatan: Jika ingin menyimpan atau menampilkan gambar,
                                    // Anda bisa menggunakan photo.path
                                  }
                                } else {
                                  // Jika ingin membatalkan centang (opsional untuk mempermudah testing)
                                  setState(() {
                                    _kegiatanList[index]["isDone"] = false;
                                  });
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
