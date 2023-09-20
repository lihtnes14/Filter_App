import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import "package:flutter/rendering.dart";
import "dart:ui" as ui;

import 'package:my_app/screens/preview_screen.dart';

class Screen2 extends StatelessWidget {
  GlobalKey get _globalKey => GlobalKey();

  final Uint8List imageData;

  const Screen2({Key? key, required this.imageData}) : super(key: key);

  Future<void> _saveImageToGallery(BuildContext context) async {
    final result = await ImageGallerySaver.saveImage(imageData);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved to gallery')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image to gallery')),
      );
    }
  }

  Future<void> preview_screen(BuildContext context) async {
    final repaintBoundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (repaintBoundary != null) {
      final boxImage = await repaintBoundary.toImage(pixelRatio: 1);
      final byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final uint8list = byteData.buffer.asUint8List();
        Navigator.of(_globalKey.currentContext!).push(MaterialPageRoute(
          builder: (context) => PreviewScreen(
            imageData: uint8list,
          ),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create preview image')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to find repaint boundary')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text("𝓕𝓲𝓵𝓽𝓮𝓻𝓐𝓹𝓹"), // Changed app title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: size.width, maxWidth: size.width),
              child: RepaintBoundary(
                key: _globalKey,
                child: Image.memory(
                  imageData,
                  width: size.width,
                  height: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveImageToGallery(context),
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.black26,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
