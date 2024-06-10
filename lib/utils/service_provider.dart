import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../model/KeyValue.dart';
import 'ConstanstAplication.dart';
import 'messages.dart';

class ServiceProvider {
  String urlServer = ConstanstAplication.SERVER;
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> post(String body, String url) async {
    String sms = "";
    try {
      if (ConstanstAplication.isSL) print('URL : ' + url);
      HttpClient client = new HttpClient();
      if (url.contains('https')) {
        if (ConstanstAplication.isSL) print('es https');
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
      }
      client.connectionTimeout = const Duration(seconds: 30);
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set(HttpHeaders.contentTypeHeader, 'text/plain');
      request.write(body);
      HttpClientResponse response = await request.close();
      String res = await response.transform(utf8.decoder).join();
      if (ConstanstAplication.isSL) print('RESPONSE : ' + res);
//      final int statusCode = response.body;
      client.close();
      if (res.contains('404 - Not Found')) {
        return new KeyValue("", Messages.SERVICE_NOT_FOUND);
      }
      return new KeyValue("0", res);
    } on TimeoutException catch (_) {
      sms = Messages.TIME_OUT;
    } on SocketException catch (_) {
      sms = Messages.SERVICE_NOT_FOUND;
    } catch (e) {
      sms = "Error al consumir el servicio";
    }
    return new KeyValue("", sms);
  }

  Future<dynamic> postJson(String body, String url) async {
    String sms = "";
    try {
      if (ConstanstAplication.isSL) print('URL : ' + url);
      HttpClient client = new HttpClient();
      if (url.contains('https')) {
        if (ConstanstAplication.isSL) print('es https');
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
      }
      client.connectionTimeout = const Duration(seconds: 30);
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(body);
      HttpClientResponse response = await request.close();
      String res = await response.transform(utf8.decoder).join();
      if (ConstanstAplication.isSL) print('RESPONSE : ' + res);
//      final int statusCode = response.body;
      client.close();
      if (res.contains('404 - Not Found')) {
        return new KeyValue("", Messages.SERVICE_NOT_FOUND);
      }
      return new KeyValue("0", res);
    } on TimeoutException catch (_) {
      sms = Messages.TIME_OUT;
    } on SocketException catch (_) {
      sms = Messages.SERVICE_NOT_FOUND;
    } catch (e) {
      sms = "Error al consumir el servicio";
    }
    return new KeyValue("", sms);
  }
  Future<dynamic> get(String body, String url) async {
    String sms = "";
    try {
      if (ConstanstAplication.isSL) print('URL : ' + url);
      HttpClient client = new HttpClient();
      if (url.contains('https')) {
        if (ConstanstAplication.isSL) print('es https');
        client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
      }
      client.connectionTimeout = const Duration(seconds: 30);
      HttpClientRequest request = await client.getUrl(Uri.parse(url));
      request.write(body);
      HttpClientResponse response = await request.close();
      String res = await response.transform(utf8.decoder).join();
      if (ConstanstAplication.isSL) print('RESPONSE : ' + res);
//      final int statusCode = response.body;
      client.close();
      if (res.contains('404 - Not Found')) {
        return new KeyValue("", Messages.SERVICE_NOT_FOUND);
      }
      return new KeyValue("0", res);
    } on TimeoutException catch (_) {
      sms = Messages.TIME_OUT;
    } on SocketException catch (_) {
      sms = Messages.SERVICE_NOT_FOUND;
    } catch (e) {
      if (ConstanstAplication.isSL) print(e);
      sms = "Error al consumir el servicio";
    }
    return new KeyValue("", sms);
  }
}
