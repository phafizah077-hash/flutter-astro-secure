import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = _focusNode.hasFocus;

    return Container(
      height: 70, // Tinggi 64px sesuai dengan Figma
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          isFocused ? 0.25 : 0.20,
        ), // Fill Solid White 20%
        borderRadius: BorderRadius.circular(32), // Corner Radius 35px
        border: Border.all(
          color: Colors.white.withOpacity(
            isFocused ? 1.0 : 0.75,
          ), // Stroke Solid White 75%
          width: 0.5, // Ketebalan border 2px
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Teks Label (Contoh: "Email :")
          Text(
            widget.label,
            style: const TextStyle(
              fontFamily: 'Nunito',
              color: Colors.white, // Opacity 100% (Solid)
              fontSize: 16,
              fontWeight: FontWeight.w600, // Bold
              letterSpacing: 0.14, // Letter spacing 1%
            ),
          ),
          const SizedBox(height: 2), // Jarak tipis antara label dan input
          TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: widget.isPassword,
            keyboardType: widget.keyboardType,
            style: const TextStyle(
              fontFamily: 'Nunito',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600, // SemiBold
              letterSpacing: 0.14,
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.white.withOpacity(0.60), // Opacity 60%
                fontSize: 14,
                fontWeight: FontWeight.w600, // SemiBold
                letterSpacing: 0.14,
              ),
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
