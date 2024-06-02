
import 'package:crud_rahul/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => homepage()));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('Login', style: TextStyle(fontSize: 30),),
        backgroundColor: Colors.blue,
      ),
      body: Form(

        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 90,),

                  Align(
                    alignment: Alignment.center,
                    child: Text("Welcome Students !", style: TextStyle(
                        fontSize: 30,
                        color: Colors.green,
                        fontWeight: FontWeight.w500),),
                  ),

                  SizedBox(height: 100,),

                  TextFormField(
                    controller: email = TextEditingController(),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outline_rounded, color: Colors.blue,),
                      labelText: "Email Address ",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                        gapPadding: 2.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                        gapPadding: 2.0,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    controller: password = TextEditingController(),
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded, color: Colors.red,),
                      labelText: "Password",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                        gapPadding: 2.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue),
                        gapPadding: 2.0,
                      ),
                      suffixIcon: Icon(
                        Icons.visibility_off, color: Colors.grey,),
                    ),
                  ),

                  SizedBox(height: 15,),

                  SizedBox(
                    width: 325,
                    child: ElevatedButton(
                      onPressed: () {
                        login(email.text, password.text);
                      },
                      child: Text("LogIn",
                        style: TextStyle(color: Colors.white, fontSize: 20),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Align(
                    alignment: Alignment.center,
                    child: Text("Create an account",
                      style: TextStyle(fontSize: 18, color: Colors.blue),),
                  ),

                ],
              )
          ),
        ),
      ),

    );
  }

  login(String email, String password) async
  {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value)=>Navigator.push(context, MaterialPageRoute(
          builder: (context) => homepage())));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }
      else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance.
          signInWithEmailAndPassword(email: email, password: password);
          if (userCredential.user != null) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => homepage()));
          }
        } on FirebaseAuthException catch (ex) {
          print(ex.code.toString());
        }
      }
    }
  }
}
