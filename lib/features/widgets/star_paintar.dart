import 'dart:math';
import 'package:flutter/material.dart';

// Pindahkan StarPainter yang ada di paling bawah setiap file kamu ke sini
class StarPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random(42);

  StarPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;

    for (int i = 0; i < 70; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double baseSize = 3.0 + (random.nextDouble() * 6.0);
      double opacity = (0.3 + (random.nextDouble() * 0.7)) * animationValue;
      double currentSize =
          baseSize * (0.6 + (random.nextDouble() * 0.4) * animationValue);

      paint.color = Colors.white.withOpacity(opacity.clamp(0.1, 1.0));

      Path starPath = Path();
      starPath.moveTo(x, y - currentSize);
      starPath.quadraticBezierTo(x, y, x + currentSize, y);
      starPath.quadraticBezierTo(x, y, x, y + currentSize);
      starPath.quadraticBezierTo(x, y, x - currentSize, y);
      starPath.quadraticBezierTo(x, y, x, y - currentSize);

      canvas.drawPath(starPath, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}