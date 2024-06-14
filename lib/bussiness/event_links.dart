import 'package:flutter/material.dart';
import 'package:relevans_app/model/Dto/Eventos.dto.dart';

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

  void eventChurchImagesPage(BuildContext context,EventDto eventDto) {
    Navigator.of(context).pushNamed("/event_church_images",arguments: eventDto);
  }
  void eventAdminPage(BuildContext context) {
    Navigator.of(context).pushNamed("/event_admin");
  }
  void eventRecordPage(BuildContext context) {
    Navigator.of(context).pushNamed("/event_record");
  }
  void eventLoadAudio(BuildContext context, EventDto eventDto) {
    Navigator.of(context).pushNamed("/event_record", arguments: eventDto);
  }
}
