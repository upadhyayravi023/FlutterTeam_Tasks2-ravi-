import 'package:crud/pages/home_screen.dart';
import 'package:crud/pages/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 26, 120, 198),
          centerTitle: true,
          flexibleSpace: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Builder(builder: (context) {
            return ListView(
              children: [
                SizedBox(
                  height: 115,
                ),
                Center(
                  child: Text(
                    'Welcome Students !!',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.green),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 100),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: "Email Address",
                          prefixIconColor: Colors.cyan,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off),
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Password",
                          prefixIconColor: Colors.red,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      
                      Builder(
                        builder: (context) {
                          return ElevatedButton(
                            style: ButtonStyle(
                              shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                                minimumSize: WidgetStatePropertyAll(Size(300, 45)),
                                backgroundColor:
                                    WidgetStateProperty.all(Colors.blue)),
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) => Navigator.push(
                                          context, // BuildContext from the widget
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                        ));
                                setState(() {
                                  passwordController.text = "";
                                });
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                        backgroundColor: Colors.black,
                                          content: Text(
                                    "User with such an email not found",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  )));
                                } else if (e.code == 'wrong-password') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                          content: Text(
                                            "Wrong password provided",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                                          )));
                                }
                              }
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          );
                        }
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text("Create an Account"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}
