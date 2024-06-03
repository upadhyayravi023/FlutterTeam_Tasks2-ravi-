import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newops/Pages/homepage.dart';
import 'package:newops/Pages/signup.dart';

import '../UI_components/notify.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text field controllers for email and password
 static final _emailController = TextEditingController();
 static final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Welcome Students!",
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
              const SizedBox(
                height: 80,
              ),
              TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  )),
              const SizedBox(height: 20.0),
              // Password text field with hint text
              TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.redAccent,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  )),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: const MaterialStatePropertyAll(Size(300,45)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)
                ),
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) => Navigator.push(
                              context, // BuildContext from the widget
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()),
                            ));
                    setState(() {
                      _passwordController.text = "";
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(Notify.Notifythis("No user found for that email."));

                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(Notify.Notifythis("Wrong password provided "));

                    }
                  }
                },
                child: const Text('Log In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
              ),
              const SizedBox(height: 10.0),
              // Sign Up text

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context, // BuildContext from the widget
                    MaterialPageRoute(builder: (context) => const Signup()),
                  );
                  print('Navigate to Sign Up');
                },
                child: const Text('Create an Account'),
              ),
             const SizedBox(
               height: 150,
             )
            ],
          ),
        ),
      ),
    );
  }
}
