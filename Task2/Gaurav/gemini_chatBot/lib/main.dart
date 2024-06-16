import '../chat_screen.dart';
import '../constants/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async{
  await dotenv.load(fileName: 'lib/.env');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini Chat Bot',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.neptune500),
        useMaterial3: true,
      ),
      home: ChatScreen(),
    );
  }
}
