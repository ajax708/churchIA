import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:relevans_app/model/Dto/Eventos.dto.dart';
import 'package:relevans_app/utils/ConstanstAplication.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
const int httpStatusCreated = 201;
const int httpStatusUnauthorized = 401;
const int httpStatusForbidden = 403;

class EventBll {
  final String api = ConstanstAplication.SERVER_NEST;

  Future<List<EventDto>> getEvents() async {
    final String eventsUrl = '$api/evento/graphqlevents';
    final response = await http.post(Uri.parse(eventsUrl));

    if (response.statusCode == httpStatusCreated) {
      var jsonResponse = jsonDecode(response.body);
      var eventsList = jsonResponse['data']['findAllEventos'] as List;
      return eventsList.map((event) => EventDto.fromJson(event)).toList();
    } else if (response.statusCode == httpStatusUnauthorized) {
      throw HttpException('Unauthorized', uri: Uri.parse(eventsUrl));
    } else if (response.statusCode == httpStatusForbidden) {
      throw HttpException('Forbidden', uri: Uri.parse(eventsUrl));
    } else {
      throw HttpException('Failed to load events', uri: Uri.parse(eventsUrl));
    }
  }

  Future<List<EventDto>> getEventsLocal() async {
    final String eventsUrl = '$api/evento';

    try {
      final response = await http.get(Uri.parse(eventsUrl));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        // Map y convertir cada elemento del JSON en un objeto EventDto
        var eventsList = jsonResponse.map((event) => EventDto.fromJson(event)).toList();

        return eventsList;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }

  Future<void> uploadEvent({
    required File file,
    required String id,
    required String nombre,
    required DateTime fecha,
    required String lugar,
  }) async {
    final String uploadUrl = '$api/evento/upload';

    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    // Adicionar el archivo
    final mimeType = lookupMimeType(file.path); // Obtener el MIME type
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: basename(file.path),
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      ),
    );

    // Adicionar los datos del DTO
    request.fields['id'] = id;
    request.fields['nombre'] = nombre;
    request.fields['fecha'] = fecha.toIso8601String();
    request.fields['lugar'] = lugar;

    // Enviar la solicitud
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = jsonDecode(responseString);
      print('Response: $jsonResponse');
    } else {
      throw Exception('Failed to upload event');
    }
  }

  Future<EventDto> getEventById(String id) async {
    try {
      final String eventUrl = '$api/evento/eventByid';
      final response = await http.post(Uri.parse(eventUrl), body: {'_id': id});

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null) {
          return EventDto.fromJson(jsonResponse);
        } else {
          throw Exception('Event not found');
        }
      } else {
        throw Exception('Failed to load event: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load event: $e');
    }
  }

}