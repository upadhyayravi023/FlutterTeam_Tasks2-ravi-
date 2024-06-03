import 'package:crud_app_adi/Screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController cPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Welcome Students",
                style: TextStyle(fontSize: 26, color: Colors.green),
              ),
              SizedBox(
                height: 80,
              ),
              TextFormField(
                  controller: emailController,
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: cPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(
                      Icons.lock,
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
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  String password = passwordController.text.trim();
                  String cPassword = cPasswordController.text.trim();
                  if (password != cPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Passwords do not match!",
                        style: TextStyle(color: Colors.red),
                      ),
                    ));
                  } else if (password.length != 6) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Passwords must be 6 character",
                        style: TextStyle(color: Colors.red),
                      ),
                    ));
                  } else {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then(
                            (value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (route) => false),
                          );

                      FirebaseAuth.instance.signOut();

                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "Error Occurred! Try Again",
                          style: TextStyle(color: Colors.red),
                        ),
                      ));
                    }
                  }
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    alignment: Alignment.center,
                    height: 42,
                    width: double.infinity,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.blue,
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
