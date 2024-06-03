import 'package:crud_rahul/screens/homepage.dart';
import 'package:crud_rahul/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // final SplashService _splashService = SplashService();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) => checkLogin(context));
    // _splashService.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: 40,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "W E L C O M E",
              style: TextStyle(color: Colors.black, fontSize: 28),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkLogin(BuildContext context)async {
    final user = FirebaseAuth.instance.currentUser;
    if (user!=null) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => homepage()));
    }else{
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Loginpage()));
    }
  }

}
