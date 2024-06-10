import 'ResponseHeader.dart';

class RVM2 {
  ResponseHeader? header;
  List<String>? lista;

  RVM2({this.header, this.lista});

  factory RVM2.fromJson(Map<String, dynamic> json) {
    return RVM2(
      header: ResponseHeader.fromJson(json["header"]),
      lista: List<String>.from(json["lista"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //"header": this.header,
      "lista": this.lista,
    };
  }
}
