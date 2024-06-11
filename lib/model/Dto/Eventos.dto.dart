class EventDto {
  EventDto({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.images = const [],
  });

  int id;
  String title;
  String description;
  String date;
  List<String> images = [];

  factory EventDto.fromJson(Map<String, dynamic> json) => EventDto(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        images: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "image": images.toList() ?? [],
  };

  @override
  String toString() {
    return 'EventDto{id: $id, title: $title, description: $description, date: $date, images: $images}';
  }
}