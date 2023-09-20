import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/screens/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  // Function to show an error message as a SnackBar
  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3), // Adjust the duration as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          '𝓕𝓲𝓵𝓽𝓮𝓻𝓐𝓹𝓹', 
          style: TextStyle(
            fontFamily: 'cursive',
            fontSize: 24,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Add any action you want for the app bar button
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black,
                BlendMode.saturation,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100, // Set the desired width
              height: 100, // Set the desired height
              child: ElevatedButton(
                onPressed: () async {
                XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EditImageScreen(selectedImage: file.path)));
                  } 
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(24), // Adjust the padding as needed
                  primary: Colors.black26, // Button color
                ),
                child: Icon(
                  Icons.add,
                  size: 40, // Increased icon size
                ),
              ),
            ),
            SizedBox(height: 16), // Added space between icon and text
            Text(
              '𝑪𝒍𝒊𝒄𝒌 𝒉𝒆𝒓𝒆 𝒕𝒐 𝒔𝒆𝒍𝒆𝒄𝒕 𝒕𝒉𝒆 𝒊𝒎𝒂𝒈𝒆',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ), // Text below the icon
          ],
        ),
      ),
    );
  }
}
