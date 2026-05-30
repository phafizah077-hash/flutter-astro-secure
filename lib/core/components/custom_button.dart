import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double height;
  final double widht;

  const CustomButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.height = 55.0,
    this.widht = 124.0 
    // Sesuai spesifikasi tinggi Figma
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0, // Dibuat 0 agar flat sesuai desain
        // minimumSize mengatur lebar otomatis menyesuaikan tempat, dan tinggi fix 55
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // Sesuai radius Figma
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily:
              'Nunito', // Pastikan font Nunito didaftarkan di pubspec.yaml
          fontWeight: FontWeight.w600, // ExtraBold sesuai Figma
          fontSize: 16.0, // Ukuran font 20 sesuai Figma
        ),
      ),
    );
  }
}
