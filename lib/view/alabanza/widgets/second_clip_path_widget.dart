import 'package:flutter/material.dart';
import 'package:relevans_app/utils/custom_clip_path.dart';

class SecondClipPath extends StatelessWidget {
  const SecondClipPath({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(4),
      child: Container(
        height: 180,
        width: 430,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: AlignmentDirectional.topEnd,
              colors: [Color.fromARGB(255, 171, 169, 169), Colors.white]),
        ),
      ),
    );
  }
}
