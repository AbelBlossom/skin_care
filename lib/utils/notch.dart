import 'package:flutter/material.dart';

class NotchPainter extends CustomPainter {
  Size imgSize;
  final Color bgColor;
  NotchPainter(this.imgSize, {this.bgColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path notch = Path();
    // Size imgSize = Size(this.imgSize, this.imgSize);
    // drawing the notch
    double halfWidth = size.width / 2;
    double imgHalf = imgSize.width / 2;
    notch.lineTo(halfWidth - imgHalf - 30, 0);

    /// create notch edge
    notch.quadraticBezierTo(
      halfWidth - imgHalf,
      0,
      halfWidth - imgHalf + 10,
      imgHalf * 0.7,
    );

    notch.cubicTo(
      halfWidth - imgHalf + 30,
      imgHalf * 1.5,
      halfWidth + imgHalf - 20,
      imgHalf * 1.5,
      halfWidth + imgHalf,
      imgHalf * .7,
    );
    // notch.lineTo(
    //   halfWidth + imgHalf,
    //   imgHalf * .7,
    // );
    notch.quadraticBezierTo(
      halfWidth + imgHalf + 10,
      0,
      halfWidth + imgHalf + 35,
      0,
    );

    /// end notch edge
    notch.lineTo(halfWidth + imgHalf, 0);
    // end of notch
    notch.lineTo(size.width, 0);
    notch.lineTo(size.width, size.height);
    notch.lineTo(0, size.height);
    notch.close();
    paint.color = bgColor != null ? bgColor : Colors.green;
    canvas.drawPath(notch, paint);
  }

  @override
  bool shouldRepaint(NotchPainter oldDelegate) => oldDelegate != this;

  @override
  bool shouldRebuildSemantics(NotchPainter oldDelegate) => false;
}
