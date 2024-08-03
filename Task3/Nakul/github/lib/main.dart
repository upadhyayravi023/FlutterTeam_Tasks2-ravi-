import 'package:flutter/material.dart';
import 'package:github/provider/follower_provider.dart';
import 'package:github/screens/followers.dart';

import 'package:github/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>FollowersProvider())
    ],
    child:  MaterialApp(
      title: "githubfollowers",
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>Homepage()
      },
    ),);
  }
}
