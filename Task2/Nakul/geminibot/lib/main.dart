import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'package:geminibot/homepage.dart';

void main() async{
 await dotenv.load(fileName:".env");
 Gemini.init(apiKey:'${dotenv.env["API_key"].toString()}');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "geminibot",
      initialRoute: "/",
      routes: {
        "/":(context)=>Homepage(),
      },
    );
  }
}
