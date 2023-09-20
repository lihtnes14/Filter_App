import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/screens/preview_screen.dart';
import 'package:my_app/screens/filters.dart';
import 'package:my_app/screens/saver_screen.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key? key, required this.selectedImage})
      : super(key: key);
  final String selectedImage;

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  final GlobalKey _globalKey = GlobalKey();

  final List<List<double>> filters = [
    sepia,
    greyscale,
    vintage,
    sweet,
  ];
  int currentFilterIndex = 0;

  Future<void> convertWidgetToImage() async {
    final repaintBoundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (repaintBoundary != null) {
      final boxImage = await repaintBoundary.toImage(pixelRatio: 1);
      final byteData =
          await boxImage.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final uint8list = byteData.buffer.asUint8List();
        Navigator.of(_globalKey.currentContext!).push(MaterialPageRoute(
          builder: (context) => Screen2(
            imageData: uint8list,
          ),
        ));
      } else {
        showErrorMessage(context, 'Failed to convert widget to image');
      }
    } else {
      showErrorMessage(context, 'Failed to find repaint boundary');
    }
  }

  Future<void> preview() async {
    final repaintBoundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    if (repaintBoundary != null) {
      final boxImage = await repaintBoundary.toImage(pixelRatio: 1);
      final byteData =
          await boxImage.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final uint8list = byteData.buffer.asUint8List();
        Navigator.of(_globalKey.currentContext!).push(MaterialPageRoute(
          builder: (context) => PreviewScreen(
            imageData: uint8list,
          ),
        ));
      } else {
        showErrorMessage(context, 'Failed to create preview image');
      }
    } else {
      showErrorMessage(context, 'Failed to find repaint boundary');
    }
  }

  undo() {
 
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        actions: [
          ElevatedButton(
            onPressed: undo,
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black,
                BlendMode.saturation,
              ),
              child: Icon(
                Icons.undo_rounded,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: convertWidgetToImage,
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black,
                BlendMode.saturation,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: RepaintBoundary(
            key: _globalKey,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.width,
                maxWidth: size.width,
              ),
              child: PageView.builder(
                
                itemCount: filters.length,
                itemBuilder: (context, currentFilterIndex) {
                  return ColorFiltered(
                    colorFilter:
                        ColorFilter.matrix(filters[currentFilterIndex]),
                    child: Image.file(
                      File(widget.selectedImage),
                      width: size.width,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: preview,
        child: Icon(
          Icons.preview,
          color: Colors.white,
        ),
        backgroundColor: Colors.black54,
      ),
    );
  }
}

void showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
