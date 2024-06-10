

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';
import 'package:relevans_app/model/music.dart';
import 'package:relevans_app/model/response/trackDto.dart';
import 'package:relevans_app/utils/ConstanstAplication.dart';
import 'package:relevans_app/view/widgets/art_work_image.dart';

import 'package:relevans_app/view/widgets/custom_navigationbar.dart';

import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

//widgets
import 'widgets/appbar_music_player_widget.dart';
import 'widgets/lyric_button_widget.dart';
import 'widgets/music_image_widget.dart';
import 'widgets/next_button_widget.dart';
import 'widgets/play_time_bar_widget.dart';
import 'widgets/previous_button_widget.dart';

class MusicPlayerView extends StatefulWidget {
  const MusicPlayerView({super.key});

  @override
  State<MusicPlayerView> createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends State<MusicPlayerView> {
  int _currentPage = 2;
  String trackId = '';
  int index = 0;
  Music music = Music();

  String clientId = ConstanstAplication.API_KEY_SPOTIFY_CLIENT;
  String clientSecret = ConstanstAplication.API_KEY_SPOTIFY_SECRET;

  final player = AudioPlayer();
  Duration? duration;

  late TrackDto _trackDto;
  bool isLoading = false;

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializePlaylist();
    });
    super.initState();
    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        playNextSong();
      }
    });
  }

  void initializePlaylist() {
    _trackDto = ModalRoute.of(context)!.settings.arguments as TrackDto;
    trackId = _trackDto.idTrack;

    print('Musica repoductor : $trackId');
    _loadMusic(trackId!);
    }


  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarMusicPlayer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 1000,
            ),
            Container(
              color: Colors.black,
              height: 455,
              width: screenWidth,
              child: Opacity(
                  opacity: 0.3, child: ArtWorkImage(image: music.songImage)),
            ),
            Center(
              child: Column(
                children: [
                  MusicImage(music: music), //music_image_widget
                   Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      music.songName ?? "",
                      style:const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      music.artistName ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 330, left: 15, right: 15),
              child: PlayTimeBar(
                  player: player, music: music), //play_time_bar_widget
            ),

            //BOTONES
            Positioned(
              top: 360,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0), // Ajusta el valor según sea necesario
                    child: previousButtonWidget(),
                  ),
                  playPauseButtonWidget(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0), // Ajusta el valor según sea necesario
                    child: nextButtonWidget(),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 440, left: 70, right: 70),
              child: _verLetra(), //lyric_button_widget
            ),

            if (isLoading)
              _loading(),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentPage: _currentPage),
    );
  }

  _loadMusic(String trackId){
    setState(() {
      isLoading = true;
    });
    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final spotify = SpotifyApi(credentials);
    spotify.tracks.get(trackId).then((track) async {
      String? tempSongName = track.name;
      if (tempSongName != null) {
        music.songName = tempSongName;
        music.artistName = track.artists?.first.name ?? "";
        String? image = track.album?.images?.first.url;
        if (image != null) {
          music.songImage = image;
          final tempSongColor = await getImagePalette(NetworkImage(image));
          if (tempSongColor != null) {
            music.songColor = tempSongColor;
          }
        }
        music.artistImage = track.artists?.first.images?.first.url;
        final yt = YoutubeExplode();
        final video =
            (await yt.search.search("$tempSongName ${music.artistName ?? ""}"))
                .first;
        final videoId = video.id.value;
        music.duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        await player.play(UrlSource(audioUrl.toString()));
        setState(() {
          isLoading = false;
        });
      }
    });
  }
  Widget _verLetra() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(18.0),
        ),
        clipBehavior: Clip.hardEdge,
        height: 70,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
           ),
          onPressed: () {}, // No hace nada cuando se presiona
          child: const Center(
            child: Text(
                'Ver Letra',
                style: TextStyle(color: Colors.white, fontSize: 20)
            ),
          ),
        )
    ) ;
  }

  Widget previousButtonWidget() {
    return IconButton(
      onPressed: () {
        if(_trackDto.listaWithTrack != null && _trackDto.index != 0){
          _trackDto.index = _trackDto.index - 1;
          trackId = _trackDto.listaWithTrack![_trackDto.index].track?.id ?? '';
          _loadMusic(trackId);
        }
        else{
          return;
        }
      },
      icon: const Icon(
        Icons.skip_previous,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  Widget playPauseButtonWidget() {
    return IconButton(
      onPressed: () async {
        if (player.state == PlayerState.playing) {
          await player.pause();
        } else {
          await player.resume();
        }
        setState(() {});
      },
      icon: Icon(
        player.state == PlayerState.playing
            ? Icons.pause_circle_outline
            : Icons.play_circle_outline,
        color: Colors.white,
        size: 50,
      ),
    );
  }

  Widget nextButtonWidget() {
    return IconButton(
      onPressed: () {
        if(_trackDto.listaWithTrack != null && _trackDto.index < _trackDto.listaWithTrack!.length - 1){
          _trackDto.index = _trackDto.index + 1;
          trackId = _trackDto.listaWithTrack![_trackDto.index].track?.id ?? '';
          _loadMusic(trackId);
        }
        else{
          return;
        }
      },
      icon: const Icon(
        Icons.skip_next,
        color: Colors.white,
        size: 40,
      ),
    );
  }
  void playNextSong() {
    if(_trackDto.listaWithTrack != null && _trackDto.index < _trackDto.listaWithTrack!.length - 1){
      _trackDto.index = _trackDto.index + 1;
      trackId = _trackDto.listaWithTrack![_trackDto.index].track?.id ?? '';
      _loadMusic(trackId);
    }
  }

_loading(){
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.3, // Ajusta esto según sea necesario
    left: MediaQuery.of(context).size.width * 0.1, // Ajusta esto según sea necesario
    right: MediaQuery.of(context).size.width * 0.1, // Ajusta esto según sea necesario
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0), // Ajusta el valor para cambiar el radio del borde
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Cargando..."),
            ],
          ),
        ),
      ),
    ),
  );
}
}
