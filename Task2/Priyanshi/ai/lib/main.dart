import 'package:ai/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  Gemini.init(apiKey: dotenv.env['API_KEY'].toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini ChatBot',
      theme: ThemeData(primaryColor: Color.fromARGB(255, 59, 14, 119)),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
