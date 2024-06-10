//crear clase pastor solo con nombre e imagen en b64

class Pastor {
  String? name;
  String? image;

  Pastor({ this.name,  this.image});

  factory Pastor.fromJson(Map<String, dynamic> json) {
    return Pastor(
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}