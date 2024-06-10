import 'dart:convert';

import 'package:relevans_app/model/KeyValue.dart';
import 'package:relevans_app/model/request/RVM1.dart';
import 'package:relevans_app/model/request/RequestHeader.dart';
import 'package:relevans_app/model/response/Mensaje.dart';
import 'package:relevans_app/model/response/RVM2.dart';
import 'package:relevans_app/utils/ConstanstService.dart';

import '../utils/ConstanstAplication.dart';
import '../utils/bll_base.dart';

class HomeService extends BllBase{
  RVM2 objectList = RVM2();
  String server;
  List<String> list = [];

  HomeService({required this.server});

  @override
  Future getRequest() async {
    final requestHeader =  getRequestHeader();
    RequestHeader rh = await requestHeader;
    RVM1 rvm1 = RVM1(header: rh, cantidad: 5);
    return rvm1;
  }

  @override
  Future onProcess() async{
      RVM1 rvm1 = await getRequest() as RVM1;
      String json = jsonEncode(rvm1);
      KeyValue keyValue = await consumeJson(json, server + ConstantsService.LIST_MENSAJES);
      if (keyValue.code != '') {
        final value = await onProcessResponse(keyValue.value);
        return value;
      } else {
        return keyValue;
      }
  }

  @override
  Future onProcessResponse(String jsonObject)async {
    var rmv2 = RVM2();
    try{
      if(!this.isJSON(jsonObject)){
        return KeyValue('9999', jsonObject);
      }

      final json = await jsonDecode(jsonObject);
      rmv2 = RVM2.fromJson(json);
      if(rmv2.header!.codReturn != '0'){
        return KeyValue(rmv2.header!.codReturn, rmv2.header!.txtReturn);
      }
      this.list = rmv2.lista!;
      this.objectList = rmv2;
    }catch(e){
      if (ConstanstAplication.isSL) print(e);
      return KeyValue('','Error al intentar procesar la respuesta');
    }
    return KeyValue(rmv2.header!.codReturn, jsonObject);
  }

  bool isJSON(str) {
    try {
      jsonDecode(str);
    } catch (e) {
      return false;
    }
    return true;
  }
}