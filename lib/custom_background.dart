import 'package:MyInv_flutter/app_properties.dart';
import 'package:flutter/material.dart';

class MainBackground extends CustomPainter {
  MainBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    canvas.drawRect(
        Rect.fromLTRB(0, 0, width, height), Paint()..color = Colors.blueGrey.withOpacity(0.52));
    canvas.drawRect(Rect.fromLTRB(width - (width / 3), 0, width, height),
        Paint()..color = Colors.black54.withOpacity(0.42));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
