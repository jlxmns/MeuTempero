import 'package:flutter/material.dart';
import 'views/screens/welcomescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sans',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}