import 'dart:core';
import 'package:flutter/material.dart';
import 'Pages/ChatScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main()async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatScreen(title: 'My AI ChatBot'),
      debugShowCheckedModeBanner: false,
    );
  }
}




