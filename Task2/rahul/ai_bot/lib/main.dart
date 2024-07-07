import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'screens/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main () async {
  await dotenv.load(fileName: "apikey.env");
  Gemini.init(apiKey: '${dotenv.env["API_key"].toString()}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Gemini AI',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/':(context) => home(),
      },
    );
  }
}
