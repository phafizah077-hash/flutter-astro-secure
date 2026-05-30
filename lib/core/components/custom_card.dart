import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String time;
  final bool isDone;
  final VoidCallback onActionTap;
  final Color actionButtonColor;
  final Color actionIconColor;

  const CustomCard({
    Key? key,
    required this.title,
    required this.time,
    required this.isDone,
    required this.onActionTap,
    this.actionButtonColor = const Color(0xFFE2CEFF),
    this.actionIconColor = const Color(0xFF3A3C9B),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Opacity(
        // Jika sudah selesai (isDone), card dibuat sedikit pudar (faded) sesuai desain Figma
        opacity: isDone ? 0.55 : 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                // Card transparan glassmorphism violet-blue
                color: isDone
                    ? Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDone
                      ? Colors.white.withOpacity(0.15)
                      : Colors.white.withOpacity(0.35),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  // --- 1. Teks Judul & Detail Waktu Kegiatan ---
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: isDone
                                ? FontWeight.normal
                                : FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          time,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.white.withOpacity(0.65),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // --- 2. Tombol Aksi di Sebelah Kanan (Kamera atau Centang) ---
                  GestureDetector(
                    onTap: onActionTap,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: isDone
                            ? Colors.white.withOpacity(
                                0.1,
                              ) // Tombol redup transparan jika selesai
                            : actionButtonColor, // Tombol ungu pastel terang jika aktif
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDone
                              ? Colors.white.withOpacity(0.2)
                              : Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        isDone ? Icons.check_rounded : Icons.camera_alt_rounded,
                        color: isDone
                            ? Colors.white.withOpacity(0.8)
                            : actionIconColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
