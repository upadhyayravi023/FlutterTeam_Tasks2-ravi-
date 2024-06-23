import 'package:flutter/material.dart';
import 'package:geminibot/homepage.dart';

void main() {
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
