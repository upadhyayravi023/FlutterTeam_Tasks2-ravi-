import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_chatbot/env/env.dart';
import 'package:gemini_chatbot/pages/chat_page.dart';

void main() {
  Gemini.init(
    apiKey: Env.geminiApiKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
            useMaterial3: true,
      ),
      home: const ChatPage(),
    );
  }
}

