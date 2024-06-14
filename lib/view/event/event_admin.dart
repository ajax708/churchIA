
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relevans_app/bll/EventBll.dart';
import 'package:relevans_app/bussiness/event_links.dart';
import 'package:relevans_app/model/Dto/Eventos.dto.dart';
import 'package:relevans_app/view/alabanza/widgets/first_clip_path_widget.dart';
import 'package:relevans_app/view/event/widgets/appbar_event.dart';
import 'package:relevans_app/view/widgets/custom_navigationbar.dart';

class EventChurchAdminView extends StatefulWidget{
  const EventChurchAdminView({Key? key}) : super(key: key);

  @override
  _EventChurchAdminViewState createState() => _EventChurchAdminViewState();
}

class _EventChurchAdminViewState extends State<EventChurchAdminView>{
  int currentPage = 2;
  late List<EventDto> _listaEventos = [];
  @override
  void initState() {

    super.initState();
    _loadEvents();
  }

  void _loadEvents() async {
    EventBll eventBll = EventBll();
    try {
      _listaEventos = await eventBll.getEvents();
      setState(() {}); // Actualizar la UI con los nuevos datos
    } on HttpException catch (e) {
      if (e.message == 'Unauthorized' || e.message == 'Forbidden') {
        //showmessage diciendo sesion expirada
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesión expirada. Por favor, inicie sesión de nuevo.'),
            duration: Duration(seconds: 3), // Duración del mensaje
          ),
        );

        // Esperar un poco antes de navegar para que el usuario vea el mensaje
        await Future.delayed(const Duration(seconds: 3));

        // Navegar a la pantalla de inicio de sesión
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Mostrar un mensaje de error genérico o manejar otros errores
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load events')),
        );
      }
    } catch (e) {
      // Manejar cualquier otro tipo de excepción
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
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
        // Lógica para manejar el evento
        // Puedes navegar a la página del evento o mostrar detalles
        print('Evento seleccionado: ${event.toString()}');
        EventLink eventLink = EventLink();
        eventLink.eventLoadAudio(context, event);
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
}