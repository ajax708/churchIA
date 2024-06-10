//import 'package:flutter/cupertino.dart';

//import '../model/screen_arguments.dart';
import 'ConstanstAplication.dart';
import 'package:http/http.dart' as http;

Future<String> getIp() async {
  String url = ConstanstAplication.URL_IP;
  String ip = '0.0.0.0';
  try {
    final response = await http.get(Uri.parse(url));
    var responseData = response.body;
    return responseData;
  } catch (e) {
    return ip;
  }
}
