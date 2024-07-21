import 'package:flutter/material.dart';

import 'package:github/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "githubfollowers",
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>Homepage()
      },
    );
  }
}
