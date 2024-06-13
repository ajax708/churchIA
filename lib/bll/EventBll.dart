import 'dart:convert';

import 'package:relevans_app/utils/ConstanstAplication.dart';
import 'package:http/http.dart' as http;

class EventBll {
  final String api = ConstanstAplication.SERVER_NEST;

  Future<List<dynamic>> getEvents() async {
    final String eventsUrl = '$api/eventos';
    final response = await http.get(Uri.parse(eventsUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load events');
    }
  }
}