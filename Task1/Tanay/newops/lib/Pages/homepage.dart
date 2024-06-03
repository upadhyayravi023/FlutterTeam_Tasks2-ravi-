import 'package:flutter/material.dart';
import 'package:newops/UI_components/cstextin.dart';
import 'package:newops/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newops/UI_components/streambuilder.dart';
import 'package:newops/Pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final db = FirebaseFirestore.instance;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student App',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Image(
                height: 170,
                width: 170,
                image: AssetImage("assets/images/student.png")),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context, // BuildContext from the widget
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
              ),
              child: const Text("Logout",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            Cstextin.CustomTextField(
                "assets/images/profile.png", "  Name", Globals.getName),
            Cstextin.CustomTextField("assets/images/id.png", "  Roll Number",
                Globals.getstudentRoll),
            Cstextin.CustomTextField("assets/images/stream.png",
                "  Study Program", Globals.getstudyProgram),
            Cstextin.CustomTextField(
                "assets/images/credit.png", " CGPA", Globals.getgpa),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Globals.create(Globals.studentName, Globals.studentRoll,
                        Globals.studyProgram, Globals.gpa, db);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    "Create",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Globals.collection_name = Globals.collection_name;
                      Globals.show = !Globals.show;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.yellowAccent),
                  ),
                  child:
                      const Text("Read", style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Globals.update(Globals.studentName, Globals.studentRoll,
                        Globals.studyProgram, Globals.gpa, db);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text("Update",
                      style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Globals.delete(Globals.studentName, db);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                  child: const Text("Delete",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: SizedBox(
                height: 300,
                width: 360,
                child: Globals.show
                    ? Data.datalist()
                    : const Text("Click Read to see student list", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
