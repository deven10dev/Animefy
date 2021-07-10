import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hacktoon/models/anime.dart';
import 'package:hacktoon/screens/final_screen.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tflite/tflite.dart';

class NavigationScreen extends StatefulWidget {
  static const String id = "navigation_screen";

  NavigationScreen({this.imageInfos});
  final Map<String, dynamic> imageInfos;

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List _outputs;
  bool _loading = true;
  var charId;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });

      classifyImage(widget.imageInfos['imageFile']);
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var outputs = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    this.setState(() {
      _loading = false;
      _outputs = outputs;
    });

    AnimeCharacter charact = new AnimeCharacter(_outputs[0]['label']);
    var jikan = Jikan();
    charId = await jikan.getCharacterInfo(charact.getId());

    getCharName();
  }

  void getCharName() {
    print(_outputs);

    if (!_loading) {
      Navigator.popAndPushNamed(
        context,
        FinalScreen.id,
        arguments: <String, dynamic>{
          'charName': _outputs[0]['label'],
          'confidence': _outputs[0]['confidence'],
          'imageFile': widget.imageInfos['imageFile'],
          'charId': charId,
        },
      );
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 700)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: LoadingIndicator(
                    indicatorType: Indicator.pacman,
                    color: Colors.yellowAccent[700],
                  ),
                ),
              );
            else
              return Container();
          },
        ),
      ),
    );
  }
}
