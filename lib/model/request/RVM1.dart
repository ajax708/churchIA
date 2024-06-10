import 'RequestHeader.dart';

class RVM1 {
  RequestHeader? header;
  int? cantidad;

  RVM1({this.header, this.cantidad});

  factory RVM1.fromJson(Map<String, dynamic> json) {
    return RVM1(
      header: RequestHeader.fromJson(json["header"]),
      cantidad: int.parse(json["cantidad"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "header": this.header,
      "cantidad": this.cantidad,
    };
  }
}