
import 'dart:convert';

import 'package:relevans_app/utils/ConstanstAplication.dart';
import 'package:http/http.dart' as http;
class AuthBll {
  final String api = ConstanstAplication.SERVER_NEST;

  Future<String> login(String email, String password) async {
    String token = '';
    final String loginUrl = '$api/auth/loginService';
    final response = await http.post(Uri.parse(loginUrl), body: {
      'username': email,
      'password': password,
    });
    if (response.statusCode == 201) {
      var responseBody = jsonDecode(response.body);
      token = responseBody['accessToken'];
      print('Token: $token');
      return token;
    } else {
      return token;
      throw Exception('Failed to load playlist');
    }
  }
}