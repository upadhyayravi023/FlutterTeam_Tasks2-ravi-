import 'package:flutter/material.dart';
import '../services/splashService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  final SplashService _splashservice = SplashService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashservice.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text("Welcome!",style: TextStyle(fontSize: 48,color: Colors.black),))),
    );
  }
}

