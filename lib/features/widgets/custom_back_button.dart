import 'package:flutter/material.dart';

// Ini adalah pengganti fungsi _buildHeaderButton yang ada di semua halaman
class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomBackButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFE2CEFF), // Warna ungu pastel solid
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xFF3A3C9B), // Warna ungu gelap
          size: 18,
        ),
      ),
    );
  }
}
