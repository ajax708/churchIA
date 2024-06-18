
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:relevans_app/model/Dto/Eventos.dto.dart';
import 'package:relevans_app/utils/ConstanstAplication.dart';
import 'package:relevans_app/view/alabanza/widgets/first_clip_path_widget.dart';
import 'package:relevans_app/view/event/widgets/appbar_event_images.dart';
import 'package:relevans_app/view/widgets/custom_navigationbar.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class EventChurchImages extends StatefulWidget {
  const EventChurchImages({Key? key}) : super(key: key);

  @override
  _EventChurchImagesState createState() => _EventChurchImagesState();
}

class _EventChurchImagesState extends State<EventChurchImages> {

  int currentPage = 3;
  EventDto? _eventDto;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initializeEventDto();
    });
  }

  void initializeEventDto() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is EventDto) {
      setState(() {
        _eventDto = arguments;
      });
    } else {
      // Manejar el caso donde no se proporcionan argumentos válidos de EventDto
      developer.log('Invalid arguments for EventDto');
      // Puedes manejar esto mostrando un mensaje de error o navegando atrás, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarEventImages(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            titleEvent(_eventDto?.nombre ?? ''),
            listImages(_eventDto?.images ?? []),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentPage: currentPage),
    );
  }

  Widget titleEvent(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 20),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget listImages(List<String> images) {
    if (images.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 3 / 2,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) => Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: _imageContainerVisualizer(images[index], index),
            ),
          ),
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _imageContainerVisualizer(String image, int index) {
    bool isBase64 = image.startsWith("data:image");

    return Stack(
      fit: StackFit.expand,
      children: [
        isBase64
            ? Image.memory(base64Decode(image.split(',')[1]), fit: BoxFit.cover)
            : Image.network(image, fit: BoxFit.cover),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.download, color: Colors.white),
              onPressed: () async {
                await _downloadImage(context, image, isBase64);
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _downloadImage(BuildContext context, String image, bool isBase64) async {
    Uint8List bytes;
    String extension;

    if (!await storagePermission()) {
      return;
    }

    if (isBase64) {
      bytes = base64Decode(image.split(',')[1]);
      extension = _getImageExtension(image);
    } else {
      String uriImage = image;
      final response = await http.get(Uri.parse(uriImage));
      if (response.statusCode == 200) {
        bytes = response.bodyBytes;
        extension = _getImageExtensionFromUrl(uriImage);
      } else {
        developer.log('Error downloading image: ${response.statusCode}');
        return;
      }
    }

    final directory = await getExternalStorageDirectory();
    if (directory != null) {
      final path = '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.$extension';
      final file = File(path);
      await file.writeAsBytes(bytes);

      final result = await ImageGallerySaver.saveFile(file.path);
      developer.log('Image saved result: $result');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image saved to gallery')),
      );
    } else {
      developer.log('Error accessing external storage directory');
    }
  }

  String _getImageExtension(String base64) {
    String mime = base64.split(';')[0];
    return mime.split('/')[1];
  }

  String _getImageExtensionFromUrl(String url) {
    return url.split('.').last.split('?')[0];
  }

  Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final int androidVersion = int.parse(androidInfo.version.release);

    bool havePermission = false;

    if (androidVersion >= 13) {
      final request = await [
        Permission.photos,
      ].request();

      havePermission = request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      await openAppSettings();
    }

    return havePermission;
  }
}