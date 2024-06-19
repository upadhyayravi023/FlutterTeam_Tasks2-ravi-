import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../chat_screen.dart';
import '../constants/color_scheme.dart';
import 'package:flutter/material.dart';


void main() async{
  await dotenv.load(fileName: 'lib/.env');
  Gemini.init(apiKey: dotenv.env['API_KEY'].toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gemini Chat Bot',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.neptune700),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}
