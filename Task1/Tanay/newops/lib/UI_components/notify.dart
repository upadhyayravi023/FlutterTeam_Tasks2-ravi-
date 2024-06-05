import 'package:flutter/material.dart';

class Notify{
  static Notifythis(String  text_message){
    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      content:Text(text_message, textAlign: TextAlign.center,style: TextStyle(color: Colors.blue),)
    );
    return (snackBar);
  }
}

