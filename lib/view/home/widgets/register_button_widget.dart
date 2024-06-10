import 'package:flutter/material.dart';
import 'package:relevans_app/bussiness/home_links.dart';

class RegisterButton extends StatelessWidget {
  final HomeLink homeLink;
  const RegisterButton({Key? key, required this.homeLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          const Color color = Colors.white;
          return const BorderSide(color: color, width: 2);
        }),
      ),
      onPressed: () {
        //homeLink.registerPage(context);
      },
      child: const Text(
        'Regístrate',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
