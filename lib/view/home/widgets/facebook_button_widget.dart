import 'package:flutter/material.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.facebook_outlined,
          color: Colors.white,
          size: 45,
        ));
  }
}
