import 'package:flutter/material.dart';

class HomeLink {
  void registerPage(BuildContext context) {
    Navigator.of(context).pushNamed("/user_register");
  }

  void alabanzaPage(BuildContext context) {
    Navigator.of(context).pushNamed("/alabanza");
  }

  void eventPage(BuildContext context) {
    Navigator.of(context).pushNamed("/event");
  }
}