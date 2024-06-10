class RequestHeader {
  late String? user = "";

  RequestHeader({  this.user});

  factory RequestHeader.fromJson(Map<String, dynamic> json) {
    return RequestHeader(
      user: json["user"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": this.user,
    };
  }
}