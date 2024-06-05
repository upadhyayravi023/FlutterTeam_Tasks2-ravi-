import 'dart:math';


import 'package:crudapp/firebase_options.dart';
import 'package:crudapp/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task2flutter",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/":(context) =>Login(),
      },
    );
  }
}
