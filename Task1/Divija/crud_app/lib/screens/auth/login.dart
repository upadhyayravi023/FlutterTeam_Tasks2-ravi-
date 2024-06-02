import 'dart:developer';

import 'package:crud_app/screens/auth/signup.dart';
import 'package:crud_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      log('PLease fill all the deatils');
    }
    else {

      try {
        UserCredential userCredential = await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => StudentRecordPage()));
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
        title: Text('Login',
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
                  Padding(
                    padding: const EdgeInsets.all(55.0),
                    child: Text('Welcome Students!',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline,
                      color: Colors.blue),
                      labelText: 'Email Address',
                      hintText: 'Enter Email Address'
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                          },
                          icon: Icon(Icons.visibility_off_sharp)),
                        prefixIcon: Icon(Icons.lock,
                        color: Colors.deepOrange,),
                        labelText: 'Password',
                        hintText: 'Enter Password'
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.blue,
                              minimumSize: Size(300, 50)
                            ),
                            onPressed: () {
                            login();
                            },
                            child: Text('Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),)
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                                minimumSize: Size(300, 50)
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute (
                                builder: (context) => SignUpScreen()
                              ));
                            },
                            child: Text('Create an Account')
                        ),
                      ],

                    )
                  )
                ],
              ),
            ),

          ],
        )
      ),

    );
  }
}
