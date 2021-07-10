import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hacktoon/screens/navigation_screen.dart';
import 'package:hacktoon/widgets/bottom_button.dart';
import 'package:hacktoon/widgets/icon_text_button.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  static const String id = 'camera_screen';

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File imageFile;
  bool _imageSelected = false;

  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var picture = await File(image.path);

      this.setState(() {
        imageFile = picture;
      });
    }
  }

  _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      var picture = await File(image.path);

      this.setState(() {
        imageFile = picture;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile == null)
      _imageSelected = false;
    else
      _imageSelected = true;

    return Scaffold(
      appBar: AppBar(
        title: Text("Animefy"),
        backgroundColor: Color(0xFFF24B41),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red.shade800,
              Colors.pink.shade800,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageSelected
                ? Container()
                : Expanded(
                    flex: 1,
                    child: Container(),
                  ),
            _imageSelected ? SizedBox(height: 10) : Container(),
            Expanded(
              flex: 2,
              child: imageFile == null
                  ? Column(
                      children: [
                        Image.asset('images/no_image_selected.png'),
                        SizedBox(height: 10),
                        Text(
                          "No image selected",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20),
                  IconTextButton(
                    text: "Camera",
                    data: FontAwesomeIcons.camera,
                    openAction: _openCamera,
                  ),
                  SizedBox(width: 20),
                  IconTextButton(
                    text: "Gallery",
                    data: FontAwesomeIcons.images,
                    openAction: _openGallery,
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            BottomButton(
              onTap: () {
                if (_imageSelected)
                  Navigator.pushNamed(
                    context,
                    NavigationScreen.id,
                    arguments: <String, dynamic>{
                      "imageFile": imageFile,
                    },
                  );
              },
              buttonTitle: "Go",
              imageSelected: _imageSelected,
            ),
          ],
        ),
      ),
    );
  }
}
