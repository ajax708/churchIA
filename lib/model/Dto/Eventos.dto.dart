class EventDto {

  EventDto({
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.lugar,
    this.images = const [],
  });

  String id;
  String nombre;
  String fecha;
  String lugar;
  List<String> images = [];

  factory EventDto.fromJson(Map<String, dynamic> json) {
    return EventDto(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      fecha: json['fecha'] ?? '',
      lugar: json['lugar'] ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'].map((image) => image.toString()))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "fecha": fecha,
    "lugar": lugar,
    "images": List<dynamic>.from(images.map((x) => x)),
  };

  @override
  String toString() {
    return 'EventDto{id: $id, nombre: $nombre, fecha: $fecha, lugar: $lugar, images: $images}';
  }
}