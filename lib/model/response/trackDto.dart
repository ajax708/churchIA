
import 'package:spotify/spotify.dart';

class TrackDto{
  String idTrack;
  List<PlaylistTrack>? listaWithTrack;
  int index;

  TrackDto({
    required this.idTrack,
    this.listaWithTrack,
    required this.index,
  });
}