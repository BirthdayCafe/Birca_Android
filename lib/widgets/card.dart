import 'package:flutter/cupertino.dart';

import '../assets/designsystem/palette.dart';

class BubblePainter extends CustomPainter {
  final int idx;

  const BubblePainter({required this.idx});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Palette.gray02
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    double width = size.width + 290;
    double height = size.height;
    double arrowHeight = 15.0;

    Path path = Path()
      ..moveTo(width / 2 - 10, 0)
      ..lineTo(width / 2, -arrowHeight)
      ..lineTo(width / 2 + 10, 0)
      ..lineTo(width - 0, 0)
      ..quadraticBezierTo(width, 0, width, 0)
      ..lineTo(width, height - 0)
      ..quadraticBezierTo(
          width, height, width - 0, height)
      ..lineTo(0, height)
      ..quadraticBezierTo(0, height, 0, height - 0)
      ..lineTo(0, 0)
      ..quadraticBezierTo(0, 0, 0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
