import 'package:flutter/material.dart';

class EventLink {
  void homePage(BuildContext context) {
    Navigator.of(context).pushNamed("/");
  }

  void alabanzaPage(BuildContext context) {
    Navigator.of(context).pushNamed("/alabanza");
  }
}
