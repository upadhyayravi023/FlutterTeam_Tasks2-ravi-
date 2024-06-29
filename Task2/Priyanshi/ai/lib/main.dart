import 'package:ai/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  Gemini.init(apiKey: "AIzaSyAgbsU7-Gc4KQx9M1XDkkbM414NlQJF6us");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini-chatbot',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
