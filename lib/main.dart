import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hacktoon/screens/camera_screen.dart';
import 'package:hacktoon/screens/final_screen.dart';
import 'package:hacktoon/screens/navigation_screen.dart';
import 'package:hacktoon/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        CameraScreen.id: (context) => CameraScreen(),
        NavigationScreen.id: (context) => NavigationScreen(
            imageInfos: ModalRoute.of(context).settings.arguments),
        FinalScreen.id: (context) =>
            FinalScreen(imageInfos: ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
