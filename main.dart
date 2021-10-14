import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final url =
      "https://ramenparados.com/wp-content/uploads/2019/12/To-Aru-Kagaku-no-Railgun-T-destacado.jpg";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(children: [
            Image.network(url),
            FloatingActionButton(
                onPressed: () {
                  _image_dowmloader();
                },
                child: Icon(Icons.download))
          ]),
        ),
      ),
    );
  }

  _image_dowmloader() async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(url,
          destination: AndroidDestinationType.directoryDownloads
            ..subDirectory("flutter_image-png"));
      print("Image Downloaded");
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
  }
}
