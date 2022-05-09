import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whats_up/new_screen/landing_screen.dart';
import 'package:whats_up/screens/camera_screen.dart';
import 'package:whats_up/screens/home_page.dart';
import 'package:whats_up/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsUp Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      home: const LoginScreen(),
    );
  }
}
