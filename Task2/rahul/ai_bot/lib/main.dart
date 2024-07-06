import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'global/const.dart';
import 'screens/home.dart';

void main (){
  Gemini.init(apiKey: API_key);
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
