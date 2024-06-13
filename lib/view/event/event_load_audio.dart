import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  bool _isRecording = false;
  double _currentPosition = 0;
  double _totalDuration = 100;
  var _audioPlayer; // Placeholder for actual audio player

  String _selectedOption = 'Grabar';
  File? _selectedFile;
  File? _recordedFile; // Placeholder for the recorded audio file

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    // Lógica de inicio de grabación
    // Almacena el archivo grabado en _recordedFile
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    // Lógica de parada de grabación
  }

  void _playRecording() {
    // Lógica de reproducción de la grabación
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadAudioFile(File audioFile) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://example.com/upload'));
    request.files.add(await http.MultipartFile.fromPath('audio', audioFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('File upload failed');
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
        child:Column(
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
                  child: const Text('Record'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isRecording ? _stopRecording : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Stop'),
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
              child: const Text('Play'),
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
              onPressed: _recordedFile != null ? () => _uploadAudioFile(_recordedFile!) : null,
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
              onPressed: _selectedFile != null ? () => _uploadAudioFile(_selectedFile!) : null,
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
}