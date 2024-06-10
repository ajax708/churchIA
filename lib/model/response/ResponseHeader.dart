class ResponseHeader {
  String codReturn = '0';
  String txtReturn =  'SUCCESS';
  ResponseHeader({required this.codReturn, required this.txtReturn});

  factory ResponseHeader.fromJson(Map<String, dynamic> json) {
    return ResponseHeader(
      codReturn: json["codReturn"],
      txtReturn: json["txtReturn"],);
  }

  Map<String, dynamic> toJson() {
    return {"codReturn": this.codReturn, "txtReturn": this.txtReturn,};
  }

}