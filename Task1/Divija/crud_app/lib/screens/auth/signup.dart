import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == '' || password == '' || cPassword == '') {
      log('Please fill all the details');
    }
      else if (password != cPassword) {
      log('Passwords do not match');
    }
    else {
      // create new account
      try {
        UserCredential userCredential = await FirebaseAuth.instance.
        createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.mail_outline,
                              color: Colors.blue),
                          labelText: 'Email Address',
                          hintText: 'Enter Email Address'
                      ),
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock,
                            color: Colors.deepOrange,),
                          labelText: 'Password',
                          hintText: 'Enter Password'
                      ),
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock,
                            color: Colors.deepOrange,),
                          labelText: ' Confirm Password',
                          hintText: 'Confirm Password'
                      ),
                      controller: cPasswordController,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    minimumSize: Size(300, 50)
                                ),
                                onPressed: () {
                                  createAccount();
                                },
                                child: Text('Create Account')
                            ),
                    )
                  ],
                ),
              ),

            ],
          )
      ),

    );;
  }
}
