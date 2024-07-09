import 'package:flutter/material.dart';
import '../providers/follower_provider.dart';
import 'package:provider/provider.dart';
import '../res/app_theme.dart';
import '../screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FollowerProvider())
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Follower',
      theme: AppTheme.themeData,
      home:  const HomeScreen(),
    ),
      );
  }
}
