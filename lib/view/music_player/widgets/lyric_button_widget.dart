import 'package:flutter/material.dart';

class LyricButton extends StatelessWidget {
  const LyricButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child:  Stack(children: [
        Center(
          child: Text(
            'Ver Letra',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]),
    );
  }
}
