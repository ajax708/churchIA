class PlaylistDto {
  final int idPlaylist;
  final String info;
  final String name;
  final String url;
  final String fechaRegistro;
  final String lastUser;

  PlaylistDto({
    required this.idPlaylist,
    required this.info,
    required this.name,
    required this.url,
    required this.fechaRegistro,
    required this.lastUser,
  });

  factory PlaylistDto.fromJson(Map<String, dynamic> json) {
    return PlaylistDto(
      idPlaylist: json['idPlaylist'],
      info: json['info'],
      name: json['name'],
      url: json['url'],
      fechaRegistro: json['fechaRegistro'],
      lastUser: json['lastUser'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPlaylist'] = this.idPlaylist;
    data['info'] = this.info;
    data['name'] = this.name;
    data['url'] = this.url;
    data['fechaRegistro'] = this.fechaRegistro;
    data['lastUser'] = this.lastUser;
    return data;
  }
}