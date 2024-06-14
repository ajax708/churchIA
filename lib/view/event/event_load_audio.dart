import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:relevans_app/model/Dto/Eventos.dto.dart';
import 'package:relevans_app/utils/ConstanstAplication.dart';

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  bool _isRecording = false;
  double _currentPosition = 0;
  double _totalDuration = 100;

  final String api = ConstanstAplication.SERVER_NEST;
  var _audioPlayer; // Placeholder for actual audio// player

  String _selectedOption = 'Grabar';
  File? _selectedFile;
  File? _recordedFile; // Placeholder for the recorded audio file

  late EventDto _eventDto ;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeEventDto();
    });
  }

  void initializeEventDto() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is EventDto) {
      setState(() {
        _eventDto = arguments;
      });
    }
  }
  // Simulated recording functionality
  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    // Simulate recording, you need to implement actual recording logic
    _recordedFile = File('path/to/recorded/file.wav');
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    // Simulate stopping the recording
  }

  void _playRecording() {
    // Simulate playing the recording, implement actual audio playback logic
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadAudioFile(File audioFile, String id, String nombre, String fecha, String lugar) async {


    var request = http.MultipartRequest('POST', Uri.parse('$api/evento/upload'));

    // Detect MIME type
    final mimeType = lookupMimeType(audioFile.path) ?? 'application/octet-stream';
    final mediaType = MediaType.parse(mimeType);

    request.files.add(
      http.MultipartFile(
        'file',
        audioFile.readAsBytes().asStream(),
        audioFile.lengthSync(),
        filename: p.basename(audioFile.path),
        contentType: mediaType,
      ),
    );

    // Add DTO fields
    request.fields['id'] = id;
    request.fields['nombre'] = nombre;
    request.fields['fecha'] = fecha;
    request.fields['lugar'] = lugar;

    await Future.delayed(Duration(milliseconds: 100));
    _showLoadingDialog(context);
    var response = await request.send();
    Navigator.pop(context);

    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = jsonDecode(responseString);
      print('Response: $jsonResponse');
    } else {
      print('File upload failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicas'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown para seleccionar la opción
            DropdownButton<String>(
              value: _selectedOption,
              items: <String>['Grabar', 'Subir']
                  .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue!;
                });
              },
              hint: const Text('Elige cómo cargar el audio'),
            ),
            const SizedBox(height: 20),

            // Vista condicional basada en la opción seleccionada
            if (_selectedOption == 'Grabar') _buildRecordingView(),
            if (_selectedOption == 'Subir') _buildUploadView(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingView() {
    return Center(
      child: Column(
        children: [
          Icon(
            _isRecording ? Icons.mic : Icons.mic_none,
            size: 100,
            color: _isRecording ? Colors.red : Colors.blue,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRecording ? null : _startRecording,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Grabar'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _isRecording ? _stopRecording : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Detener'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: !_isRecording ? _playRecording : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Reproducir'),
          ),
          Slider(
            value: _currentPosition,
            max: _totalDuration,
            onChanged: (value) {
              setState(() {
                _currentPosition = value;
              });
              // Update audio player position here
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _recordedFile != null
                ? () {
              // Cambia esto por los valores reales
              String id = _eventDto.id??"";
              String nombre = _eventDto.nombre??"";
              String fecha = _eventDto.fecha??"";
              String lugar = _eventDto.lugar??"";
              _uploadAudioFile(_recordedFile!, id, nombre, fecha, lugar);
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Subir Grabación'),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadView() {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.file_upload,
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _pickAudioFile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Seleccionar Audio'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _selectedFile != null
                ? () {
              // Cambia esto por los valores reales
              String id = _eventDto.id??"";
              String nombre = _eventDto.nombre??"";
              String fecha = _eventDto.fecha??"";
              String lugar = _eventDto.lugar??"";
              _uploadAudioFile(_selectedFile!, id, nombre, fecha, lugar);
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Subir Audio'),
          ),
          if (_selectedFile != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Archivo seleccionado: ${_selectedFile!.path.split('/').last}'),
            ),
        ],
      ),
    );
  }


  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Procesando con IA...'),
              ],
            ),
          ),
        );
      },
    );
  }
}
