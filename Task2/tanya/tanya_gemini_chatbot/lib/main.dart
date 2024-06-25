import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:tanya_gemini_chatbot/homepage.dart';

Future<void> main() async {
  Gemini.init(apiKey: 'API_key');
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName:".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 100, 167, 243),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:const Homepage(),
    ); 
  }
}
