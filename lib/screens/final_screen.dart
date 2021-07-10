import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinalScreen extends StatefulWidget {
  static const String id = "final_screen";

  FinalScreen({this.imageInfos});
  final Map<String, dynamic> imageInfos;

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  var nameKanji = "Fetching details...";
  var characterName = "Fetching details...";
  var detail = "Fetching details...";
  var likedby = "Fetching details...";
  var animeImageUrl = "";
  File personImage;

  void getCharacterInfo() async {
    var info = widget.imageInfos['charId'];

    setState(() {
      characterName = info.name;
      animeImageUrl = info.imageUrl.toString();
      likedby = info.memberFavorites.toString();

      detail = info.about.toString();
      nameKanji = info.nameKanji.toString();

      print(animeImageUrl.trim() + info.nicknames.toString());
    });
  }

  @override
  void initState() {
    getCharacterInfo();
    personImage = widget.imageInfos["imageFile"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Image.file(
                      widget.imageInfos['imageFile'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Image.network(
                      animeImageUrl.replaceAll("https:///", "https://"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Text(
                "Wow! You look " +
                    (widget.imageInfos['confidence'] * 100)
                        .toString()
                        .substring(0, 2) +
                    "% similar to ${widget.imageInfos['charName']}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red.shade700,
                    Colors.orange.shade900,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  builder: (context) => DraggableScrollableSheet(
                    maxChildSize: 1,
                    minChildSize: 0.9,
                    initialChildSize: 1,
                    builder: (_, controller) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepOrangeAccent.shade700,
                            Colors.orange.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: 10, bottom: 15, left: 20, right: 20),
                      child: ListView(controller: controller, children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(animeImageUrl.replaceAll(
                                  "https:///", "https://")),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.redAccent.shade700,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              likedby + " likes",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                        Text(
                          characterName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          nameKanji,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          detail,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.info_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          characterName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                        Text(
                          nameKanji,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
