import 'package:flutter/material.dart';

class WavyBottom extends StatelessWidget {
  const WavyBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Compact height for smaller waves
      child: CustomPaint(
        painter: WavyBottomPainter(),
      ),
    );
  }
}

class WavyBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height * 0.9); // Start closer to the bottom

    // Generate smaller waves
    for (double i = 0; i < size.width; i += size.width / 10) {
      double controlX = i + (size.width / 20); // Midpoint of each wave
      double controlY = i % 2 == 0
          ? size.height * 0.8 // Slightly above the bottom
          : size.height * 0.95; // Closer to the bottom
      double endX = i + size.width / 10; // End of the wave
      double endY = size.height * 0.9; // Same baseline for all waves
      path.quadraticBezierTo(controlX, controlY, endX, endY);
    }

    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(0, 0); // Top-left corner
    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
