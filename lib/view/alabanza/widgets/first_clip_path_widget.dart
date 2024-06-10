import 'package:flutter/material.dart';
import 'package:relevans_app/utils/custom_clip_path.dart';

class FirstClipPath extends StatelessWidget {
  const FirstClipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(3),
      child: Container(
          height: 430,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Opacity(
              opacity: 0.4,
              child: Image.asset('assets/microfono.png', fit: BoxFit.cover),
            ),
          )),
    );
  }
}
