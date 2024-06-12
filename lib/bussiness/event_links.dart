import 'package:flutter/material.dart';

class EventLink {
  void homePage(BuildContext context) {
    Navigator.of(context).pushNamed("/");
  }

  void eventChurchPage(BuildContext context) {
    Navigator.of(context).pushNamed("/event_church");
  }

  void alabanzaPage(BuildContext context) {
    Navigator.of(context).pushNamed("/alabanza");
  }

  void eventChurchImagesPage(BuildContext context) {
    Navigator.of(context).pushNamed("/event_church_images");
  }
  void eventAdminPage(BuildContext context) {
    Navigator.of(context).pushNamed("/event_admin");
  }
}
