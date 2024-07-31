import 'package:flutter/material.dart';
import 'package:github_follower/Providers/follower_provider.dart';
import 'package:github_follower/Screens/FollowerPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                  child: Text("GitHub",
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 30, horizontal: 13),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white12,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.white12,
                        )),
                    hintText: "GitHub Username",
                    hintStyle: TextStyle(fontSize: 13, color: Colors.white70),
                    fillColor: Colors.white12,
                    filled: true,
                  ),
                  controller: userName,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Consumer<followerProvider>(
                builder: (BuildContext context, followerProvider value, Widget? child) {
                return InkWell(
                  onTap: () async {
                    if(userName.text.isNotEmpty){
                      await value.getData(userName.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const FollowerPage()));
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        color: Colors.blueAccent,
                      ),
                      child: value.isLoadingData? const CircularProgressIndicator(color: Colors.white,):const Text(
                        "Get Your Followers Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
