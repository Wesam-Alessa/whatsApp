import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class OtherStatus extends StatelessWidget {
  final String name;
  final String time;
  final String image;
  final bool isSeen;
  final int statusNum;
  const OtherStatus({
    Key? key,
    required this.name,
    required this.time,
    required this.image,
    required this.isSeen,
    required this.statusNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(isSeen: isSeen, statusNum: statusNum),
        child: CircleAvatar(
          radius: Dimensions.radius25,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(image),
        ),
      ),
      title: Text(
        name,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
      subtitle: Text(
        "today at, $time",
        style: TextStyle(fontSize: Dimensions.font13, color: Colors.grey[900]),
      ),
    );
  }
}

degreeToAngel(double degree) {
  return degree * pi / 180;
}

class StatusPainter extends CustomPainter {
  bool isSeen;
  int statusNum;
  StatusPainter({
    required this.isSeen,
    required this.statusNum,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..color = isSeen ? Colors.grey : const Color(0xff21bfa6)
      ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if (statusNum == 1) {
      canvas.drawArc(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        degreeToAngel(0),
        degreeToAngel(360),
        false,
        paint,
      );
    } else {
      double degree = -90;
      double arc = 360 / statusNum;
      for (int i = 0; i < statusNum; i++) {
        canvas.drawArc(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngel(degree + 4),
          degreeToAngel(arc - 8),
          false,
          paint,
        );
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
