import 'package:flutter/material.dart';

//Widgets reutilizables
import 'package:relevans_app/view/widgets/custom_navigationbar.dart';
import 'package:spotify/spotify.dart';

//widgets
import '../../bussiness/alabanza_links.dart';
import '../../model/response/trackDto.dart';
import '../../utils/ConstanstAplication.dart';
import './widgets/appbar_playlist_widget.dart';
import 'widgets/first_clip_path_widget.dart';
import 'widgets/search_widget.dart' as flutter;
import 'widgets/listview_music_widget.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  int currentPage = 2;
  String? playlistId ;
  String clientId = ConstanstAplication.API_KEY_SPOTIFY_CLIENT;
  String clientSecret = ConstanstAplication.API_KEY_SPOTIFY_SECRET;
  List<PlaylistTrack> _listaWithTrack = [];
  String nombrePlaylist = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      initializePlaylist();
    });
  }
  void initializePlaylist() {
    playlistId = ModalRoute.of(context)?.settings.arguments as String;
    print(playlistId);
    if(playlistId != null){
      _loadMusic(playlistId!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarPlayList(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 1300,
            ),
            const FirstClipPath(), //first_clip_path_widget
             Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    nombrePlaylist,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100, left: 40, right: 40),
                child: SizedBox(
                  height: 40,
                  child: flutter.Search(), //search_widget
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 180),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 180,
                child: _listViewMusic(), //listview_music_widget
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentPage: currentPage),
    );
  }

  Widget _listViewMusic() {
    if( _listaWithTrack !=null && _listaWithTrack.length > 0){
      return ListView.builder(
        itemCount: _listaWithTrack.length,
        itemBuilder: (context, int index) => SizedBox(
          height: 100,
          child: Card(
            elevation: 5,
            child: _musicButton(
                _listaWithTrack[index],
                index
            ),
          ),
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _musicButton(PlaylistTrack playlistTrack, int index) {
    return TextButton(
      onPressed: () {

        TrackDto trackDto = TrackDto(
            idTrack: playlistTrack.track?.id ?? '',
            listaWithTrack: _listaWithTrack,
            index: index,
        );

        AlabanzaLink alabanzaLink = AlabanzaLink();
        alabanzaLink.playerMusicPage(context, trackDto);
      },
      child:  Row(
        children: [
          const SizedBox(
            height: 90,
            width: 100,
            child: Card(
              color: Color.fromARGB(255, 167, 166, 166),
              child: Icon(
                Icons.play_arrow,
                size: 60,
                color: Color.fromARGB(255, 78, 78, 78),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    playlistTrack.track?.name ?? '',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 10),
                  child: Text(playlistTrack.track?.artists?.first.name ?? '',
                      style: TextStyle(
                          color: Color.fromARGB(255, 64, 64, 64), fontSize: 15)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  _loadMusic(String idPlaylist) {
    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final spotify = SpotifyApi(credentials);
    List<PlaylistTrack> listaWithTrack = [];
    spotify.playlists.get(idPlaylist).then((playlist) {
      // Obtener las pistas paginadas de la playlist
      nombrePlaylist = playlist.name!;
      Paging<Track> playlistTracks = playlist.tracks as Paging<Track>;

      playlistTracks.itemsNative?.forEach((element) {
        listaWithTrack.add(PlaylistTrack.fromJson(element));
      });
      setState(() {
        _listaWithTrack = listaWithTrack;
        print('Cantidad de canciones: ${_listaWithTrack.length}');
      });
    }).catchError((error) {
      print('Error al obtener la lista de reproducción: $error');
    });
  }
}
