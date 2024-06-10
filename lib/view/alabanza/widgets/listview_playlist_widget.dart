import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:relevans_app/bussiness/PlaylistBusinessLogic.dart';
import 'package:relevans_app/model/response/playlistDto2.dart';

import '../../../bussiness/alabanza_links.dart';
import '../../../model/response/PlaylistDto.dart';
import '../../../utils/ConstanstAplication.dart';
import 'package:spotify/spotify.dart';

class ListViewPlayList extends StatefulWidget {
  const ListViewPlayList({Key? key}) : super(key: key);

  @override
  _ListViewPlayListState createState() => _ListViewPlayListState();
}

class _ListViewPlayListState extends State<ListViewPlayList> {
  List<PlaylistDto> _playlistsApi = [];

  List<PlayListDto2> _playlistDto = [];
  String clientId = ConstanstAplication.API_KEY_SPOTIFY_CLIENT;
  String clientSecret = ConstanstAplication.API_KEY_SPOTIFY_SECRET;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _PlayListSpotifyLoad();
  }

  @override
  Widget build(BuildContext context) {
    if (_playlistDto.isEmpty) {
      return const flutter.Center(
        child: flutter.CircularProgressIndicator(),
      );
    }else{
      return ListView.builder(
        itemCount: _playlistDto.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(left: 5),
          child: SizedBox(
            width: 160,
            child: flutter.Card(
              color: flutter.Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35),
              ),
              child: flutter.Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child:  flutter.Image.network(
                        _playlistDto[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            flutter.Colors.transparent,
                            flutter.Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _playlistDto[index].name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: flutter.Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: flutter.Material(
                        color: flutter.Colors.transparent,
                        borderRadius: BorderRadius.circular(35),
                        child: flutter.InkWell(
                          onTap: () {
                            AlabanzaLink alabanzaLink = AlabanzaLink();
                            alabanzaLink.playlistPage(context, _playlistDto[index].id ); //<-----llamada
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Future _listPlayList() async{
    PlaylistBusinessLogic playlistBusinessLogic = PlaylistBusinessLogic();
     _playlistsApi = await playlistBusinessLogic.getPlaylist();
  }

  _PlayListSpotifyLoad() async {

    await _listPlayList();

    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final spotify = SpotifyApi(credentials);
    List<PlayListDto2> playlistDto = [];
    // Lista de futuros para almacenar todas las llamadas asíncronas
    List<Future<void>> futures = [];

    _playlistsApi.forEach((listaApi) {
      if(listaApi.url != null) {
        print(listaApi.url);

        futures.add(
            spotify.playlists.get(listaApi.url).then((playlist) {
            // Obtener las pistas paginadas de la playlist
            /*Paging<Track> playlistTracks = playlist.tracks as Paging<Track>;

            playlistTracks.itemsNative?.forEach((element) {
              listaWithTrack.add(PlaylistTrack.fromJson(element));
            });*/
              playlistDto.add(PlayListDto2(
                id: playlist.id!,
                name: playlist.name ?? "",
                image: playlist.images![0].url ?? "",
              ));

          }).catchError((error) {
            print('Error al obtener la lista de reproducción: $error');
          })
        );
      }
    });

// Esperar a que todas las llamadas asíncronas se completen
    await Future.wait(futures);
    /*_playlistTracks = listaWithTrack;*/
    _playlistDto = playlistDto;

    setState(() {});
  }


}