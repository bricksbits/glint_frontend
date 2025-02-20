import 'package:flutter/material.dart';

class TicketDashedLine extends StatelessWidget {
  const TicketDashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 150), // Adjust size as needed
      painter: TicketPainter(),
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint dashPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    double dashWidth = 8;
    double dashSpace = 4;
    double startX = size.width * 0.15; // Start after the first semicircle
    double endX = size.width * 0.85; // End before the second semicircle

    // Draw horizontal dashed line
    while (startX < endX) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), dashPaint);
      startX += dashWidth + dashSpace;
    }

    // Draw semi-circle cuts on the left and right sides
    Paint cutPaint = Paint()..color = Colors.black;
    double radius = 10;

    // Left semicircle
    canvas.drawCircle(Offset(size.width * 0.15, size.height / 2), radius, cutPaint);

    // Right semicircle
    canvas.drawCircle(Offset(size.width * 0.85, size.height / 2), radius, cutPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
