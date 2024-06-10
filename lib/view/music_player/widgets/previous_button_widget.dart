import 'package:flutter/material.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.skip_previous,
          color: Colors.white,
          size: 40,
        ));
  }
}
