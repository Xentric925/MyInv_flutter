
//import 'package:MyInv_flutter/screens/auth/Login_page.dart';
import 'package:MyInv_flutter/screens/splash_page.dart';
import 'package:flutter/material.dart';

import 'models/Person.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyInv',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",

      ),
      home: SplashScreen(),
    );
  }
}
