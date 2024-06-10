import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Stack(children: [
        SizedBox(
          width: 410,
          child: Card(
            clipBehavior: Clip.hardEdge,
            color: Colors.black,
            child: Opacity(
              opacity: 0.3,
              child:
                  Image.asset('assets/manos_alabanza.png', fit: BoxFit.cover),
            ),
          ),
        ),
        const Center(
          child: Text(
            'Ver más',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]),
    );
  }
}
