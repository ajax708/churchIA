
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relevans_app/bll/EventBll.dart';
import 'package:relevans_app/bussiness/event_links.dart';
import 'package:relevans_app/model/Dto/Eventos.dto.dart';
import 'package:relevans_app/view/alabanza/widgets/first_clip_path_widget.dart';
import 'package:relevans_app/view/event/widgets/appbar_event.dart';
import 'package:relevans_app/view/playlist/widgets/appbar_playlist_widget.dart';
import 'package:relevans_app/view/widgets/custom_navigationbar.dart';

class EventChurchView extends StatefulWidget{
  const EventChurchView({Key? key}) : super(key: key);

  @override
  _EvemntChurchViewState createState() => _EvemntChurchViewState();
}

class _EvemntChurchViewState extends State<EventChurchView>{
  int currentPage = 2;
  late List<EventDto> _listaEventos = [];
  @override
  void initState() {

    super.initState();
    _loadEvents();
  }

  // Método para cargar los eventos
  _loadEvents() async {
    try {
      EventBll eventBll = EventBll();
      List<EventDto> eventos = await eventBll.getEventsLocal();

      setState(() {
        _listaEventos = eventos; // Actualiza la lista de eventos
      });
    } catch (e) {
      print('Error al cargar eventos: $e');
      // Puedes manejar el error aquí, por ejemplo, mostrar un mensaje al usuario
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:const AppbarEvent(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 1300,
            ),
            const FirstClipPath(),
            titleEvent('Eventos'),
            listEvents(_listaEventos),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentPage: currentPage),
    );
  }

  Widget titleEvent(String title){
    return Center(
        child : Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
    );
  }

  Widget listEvents(List<EventDto> listaEventos){
    return  Padding(
      padding: EdgeInsets.only(top: 180),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 180,
        child: _listViewEvents(), //listview_music_widget
      ),
    );
  }

  Widget _listViewEvents(){
    if( _listaEventos !=null && _listaEventos.length > 0){
      return ListView.builder(
        itemCount: _listaEventos.length,
        itemBuilder: (context, int index) => SizedBox(
          height: 100,
          child: Card(
            elevation: 5,
            child: _eventButton(
                _listaEventos[index],
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

  Widget _eventButton(EventDto event, int index) {
    return TextButton(
      onPressed: () {
        _viewImagesToEvent(event);
      },
      style: TextButton.styleFrom(padding: EdgeInsets.zero), // Elimina el padding para ajustar mejor el diseño
      child: Row(
        children: [
          SizedBox(
            height: 90,
            width: 100,
            child: Card(
              color: Color.fromARGB(255, 72, 203, 203),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.event,
                size: 50,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.nombre,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    event.lugar,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 64, 64, 64),
                      fontSize: 16,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _viewImagesToEvent(EventDto event)async{
    print('Evento seleccionado: ${event.toString()}');

    try {
      EventBll eventBll = EventBll();
      EventDto _eventDto = await eventBll.getEventById(event.id);

      print('Evento consumido: ${_eventDto.toString()}');

      if (_eventDto != null) {
        EventLink eventLink = EventLink();
        eventLink.eventChurchImagesPage(context, _eventDto);
      } else {
        throw Exception('Evento no encontrado');
      }
    } catch (e) {
      print('Error al cargar el evento: $e');
      // Manejar el error apropiadamente, por ejemplo, mostrar un diálogo
    }
  }
}