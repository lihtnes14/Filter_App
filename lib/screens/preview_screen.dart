import 'package:flutter/material.dart';
import 'dart:typed_data';

class PreviewScreen extends StatelessWidget {
  final Uint8List imageData;

  const PreviewScreen({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: size.width, maxWidth: size.width),
              child: Image.memory(
                imageData,
                width: size.width,
                height: size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}