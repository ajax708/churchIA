import 'package:flutter/material.dart';
import 'package:relevans_app/bussiness/home_links.dart';

class AlabanzaButton extends StatelessWidget {
  final HomeLink homeLink;

  const AlabanzaButton({Key? key, required this.homeLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
            const Color color = Colors.white;
            return const BorderSide(color: color, width: 2);
          },
        ),
      ),
      onPressed: () {
        homeLink.alabanzaPage(context);
      },
      child: const Row(
        children: [
          Icon(
            Icons.music_note,
            size: 35,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 25),
            child: Text(
              'Alabanzas',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
