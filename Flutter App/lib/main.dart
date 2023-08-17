import 'package:firebase_admin/firebase_admin.dart';
import 'package:gp/Screens/DisplayImage.dart';
import 'package:gp/Screens/Feedbacks.dart';
import 'package:gp/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:gp/Screens/PervWork.dart';
import 'package:sizer/sizer.dart';
import 'Screens/Login.dart';
import 'Screens/SplachScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dcdg/dcdg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize the SDK with your service account credentials
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => Starting(),
            '/Home': (context) => HomePage(),
            '/image': (context) => DisplayImage(),
            '/prevWork': (context) => PrevWork(),
            '/Login': (context) => Login(),
            '/feedback': (context) => Feedbacks(),
          });
    });
  }
}
