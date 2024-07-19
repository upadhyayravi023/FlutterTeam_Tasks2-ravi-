import 'package:flutter/material.dart';
import 'package:github/provider/follower_provider.dart';
import 'package:github/pages/MyHomePage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main()async {

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => FollowerProvider(),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber.shade700),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      )
    );
  }
}


