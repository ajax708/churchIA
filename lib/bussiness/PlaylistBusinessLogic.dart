import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:relevans_app/model/response/PlaylistDto.dart';


import '../utils/ConstanstAplication.dart';

class PlaylistBusinessLogic {
  final String api = ConstanstAplication.SERVER;
  final String songsUrl = 'https://example.com/songs';


  Future<List<PlaylistDto>> getPlaylist() async {

    final String playlistUrl = '$api/api-relevans/playlist/all';
    final response = await http.get(Uri.parse(playlistUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List;
      List<PlaylistDto> playlists = jsonList.map((item) => PlaylistDto.fromJson(item)).toList();
      return playlists;
    } else {
      throw Exception('Failed to load playlist');
    }
  }

  Future<List<dynamic>> getSongsByPlaylist(String playlistId) async {
    final String songsByPlaylistUrl = 'https://example.com/playlists';
    final response = await http.post(Uri.parse(songsByPlaylistUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load songs');
    }
  }
}