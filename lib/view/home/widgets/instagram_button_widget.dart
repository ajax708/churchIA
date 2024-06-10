import 'package:flutter/material.dart';
import 'package:relevans_app/utils/custom_icons.dart';

class InstagramButton extends StatelessWidget {
  const InstagramButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          CustomIcons.instagram,
          color: Colors.white,
          size: 45,
        ));
  }
}
