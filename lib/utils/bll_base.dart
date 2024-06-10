
import 'package:relevans_app/model/request/RequestHeader.dart';
import 'package:relevans_app/utils/service_provider.dart';
import 'package:relevans_app/utils/shared_pref.dart';
import 'package:intl/intl.dart';

import '../model/KeyValue.dart';
import 'ConstanstAplication.dart';

abstract class BllBase {
  final serviceProvider = new ServiceProvider();
  final sp = SharedPref();

  Future<RequestHeader> getRequestHeader() async {

    String? user = await SharedPref.getString(ConstanstAplication.USER);
    final requestHeader =  RequestHeader( user: user);

    return requestHeader;
  }

  Future<dynamic> consume(String message, String url) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String formatted = formatter.format(now);
    await SharedPref.setString(ConstanstAplication.SP_LAST_CONSUME, formatted);
    KeyValue keyValue = await serviceProvider.post(message, url);
    return keyValue;
  }

  Future<dynamic> consumeGet(String url) async {
    KeyValue keyValue = await serviceProvider.get("", url);
    return keyValue;
  }

  Future<dynamic> consumeJson(String messageJson, String url) async {
    KeyValue keyValue = await serviceProvider.postJson(messageJson, url);
    return keyValue;
  }

  Future<dynamic> onProcess();
  Future getRequest();
  Future onProcessResponse(String jsonObject);
}
