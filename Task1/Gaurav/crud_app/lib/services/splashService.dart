import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../activity/homeScreen.dart';
import '../activity/loginScreen.dart';

class SplashService{


  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!=null) {
      Timer(const Duration(seconds: 2), () =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen())));
    }else{
      Timer(const Duration(seconds: 3), () =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }

}