import 'package:flutter/material.dart';
import 'package:relevans_app/utils/custom_clip_path.dart';

class SecondClipPath extends StatelessWidget {
  const SecondClipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(2),
      child: Container(
        color: Colors.black,
        height: 485,
        child: Opacity(
          opacity: 0.4,
          child: Image.asset('assets/creyentes.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
