class PlayListDto2{
  final String id;
  final String name;
  final String image;

  PlayListDto2({
    required this.id,
    required this.name,
    required this.image,
  });

  factory PlayListDto2.fromJson(Map<String, dynamic> json) {
    return PlayListDto2(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }

}