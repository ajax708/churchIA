import 'package:flutter/material.dart';

class TikTokButton extends StatelessWidget {
  const TikTokButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.tiktok,
          color: Colors.white,
          size: 45,
        ));
  }
}
