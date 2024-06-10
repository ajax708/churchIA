import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  int type;
  //construct
  CustomClipPath(this.type);

  @override
  Path getClip(Size size) {
    final path = Path();

    switch (type) {
      case 1:
        path.lineTo(0, size.height - 200);
        path.quadraticBezierTo(
            size.width * 0.5, size.height - 300, size.width, size.height - 200);
        path.lineTo(size.width, 0);
        break;
      case 2:
        path.moveTo(size.width * 0.0011167, size.height * 0.6433286);
        path.quadraticBezierTo(size.width * 0.5015083, size.height * 1.0298714,
            size.width * 1.0060833, size.height * 0.8158714);
        path.lineTo(size.width * 1.0016667, size.height * 0.3157143);
        path.quadraticBezierTo(size.width * 0.6541667, size.height * -0.0328571,
            size.width * 0.2366667, size.height * 0.0014286);
        path.quadraticBezierTo(size.width * 0.1018750, size.height * 0.0003571,
            size.width * 0.0008333, size.height * 0.0400000);
        path.quadraticBezierTo(size.width * 0.0009000, size.height * 0.2015429,
            size.width * 0.0011167, size.height * 0.6433286);
        break;
      case 3:
        path.lineTo(0, size.height - 200);
        path.quadraticBezierTo(
            size.width * 0.5, size.height - 250, size.width, size.height - 200);
        path.lineTo(size.width, 0);
        break;
      case 4:
        path.moveTo(size.width * 0.5000000, size.height * 0.0100000);
        path.quadraticBezierTo(size.width * 0.3153167, size.height * 0.0163286,
            size.width * 0.2390667, size.height * 0.0450000);
        path.cubicTo(
            size.width * 0.1269333,
            size.height * 0.0895857,
            size.width * 0.0732833,
            size.height * 0.1276286,
            size.width * -0.0002750,
            size.height * 0.2149857);
        path.quadraticBezierTo(size.width * 0.0000750, size.height * 0.4123429,
            0, size.height * 1.0042857);
        path.lineTo(size.width * 1.0008333, size.height);
        path.quadraticBezierTo(size.width * 0.9991083, size.height * 0.4126571,
            size.width * 0.9994500, size.height * 0.2149571);
        path.quadraticBezierTo(size.width * 0.9110833, size.height * 0.0987286,
            size.width * 0.7224167, size.height * 0.0411000);
        break;
      case 5:
        path.lineTo(0, size.height - 250);
        path.quadraticBezierTo(
            size.width * 0.5, size.height - 300, size.width, size.height - 250);
        path.lineTo(size.width, 0);
        break;
      default:
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
