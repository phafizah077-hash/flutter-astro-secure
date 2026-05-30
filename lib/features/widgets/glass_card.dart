import 'dart:ui';
import 'package:flutter/material.dart';

// Ini adalah pengganti fungsi _buildGlassCard yang ada di AboutApp, Profile, dan Journey
class GlassCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double width;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    Key? key,
    required this.child,
    this.height,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
