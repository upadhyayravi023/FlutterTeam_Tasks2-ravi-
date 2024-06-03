import 'package:crud_app_adi/Screens/HomePage.dart';
import 'package:crud_app_adi/Screens/SignUpPage.dart';
import 'package:crud_app_adi/Utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      // signed in
     // FirebaseAuth.instance.signOut();
      Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text("Login",
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 80,),
              Text("Welcome Students",style: TextStyle(fontSize: 26,color: Colors.green),),
              SizedBox(height: 80,),
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
                  )
              ),
              SizedBox(height: 20,),
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
              const SizedBox(height: 40,),
              GestureDetector(
                onTap:() async {
                  try {
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text
                    )
                    .then((value) =>   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false),);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Error Occurred! Check your email or password",style: TextStyle(color: Colors.red),),
                    ));
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No User found. Kindly create an account"),
                      ));
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Wrong Password",style: TextStyle(color: Colors.red),),
                      ));
                    }
                  }
                } ,
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
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
                },
                  child: Text("Create an Account",style: TextStyle(color: Colors.blue),)
              ),
            ],
          ),
        ),
      ),
    );
    }
}
