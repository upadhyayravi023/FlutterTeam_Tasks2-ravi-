import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/pages/login_screen.dart';
import 'package:crud/widgets/button.dart';
import 'package:crud/widgets/inputbox.dart';
import 'package:crud/widgets/show.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final SidController = TextEditingController();
  final SPController = TextEditingController();
  final CGPAController = TextEditingController();
  var sname, sid, sprogram, scgpa;
  bool isShow = false;

  void LogOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    SidController.dispose();
    SPController.dispose();
    CGPAController.dispose();
  }

  getName(name) {
    this.sname = name;
  }

  getSID(ID) {
    this.sid = ID;
  }

  getSP(studentProgram) {
    this.sprogram = studentProgram;
  }

  getCGPA(CGPA) {
    this.scgpa = CGPA;
  }

  createData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    Map<String, dynamic> sdata = {
      "Name": sname,
      "Student ID": sid,
      "Student Program": sprogram,
      "CGPA": scgpa,
    };
    documentReference
        .set(sdata)
        .whenComplete(() => {print("Created Sucessfully")});
  }

  readData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    documentReference.get().whenComplete(() => {print("Read Sucessfully")});
  }

  updateData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    Map<String, dynamic> sdata = {
      "Name": sname,
      "Student ID": sid,
      "Student Program": sprogram,
      "CGPA": scgpa,
    };

    documentReference
        .update(sdata)
        .whenComplete(() => {print("Updated Sucessfully")});
  }

  deleteData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(sname);

    documentReference
        .delete()
        .whenComplete(() => {print("Deleted Sucessfully")});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text(
          "Student App",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                  backgroundColor: Colors.blue[500],
                  radius: 85,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                  Buttontext: "Logout",
                  color: Colors.red.shade800,
                  onclick: () {
                    LogOut();
                  }),
              SizedBox(
                height: 20,
              ),
              InputBox(
                Field: "Name",
                icon: "name.png",
                controllar: nameController,
                change: (name) {
                  getName(name);
                },
              ),
              InputBox(
                Field: "Student ID",
                icon: "Sid.png",
                controllar: SidController,
                change: (ID) {
                  getSID(ID);
                },
              ),
              InputBox(
                Field: "Student Program",
                icon: "program.png",
                controllar: SPController,
                change: (Program) {
                  getSP(Program);
                },
              ),
              InputBox(
                Field: "CGPA",
                icon: "cgpa.png",
                controllar: CGPAController,
                change: (cgpa) {
                  getCGPA(cgpa);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    Buttontext: "Create",
                    color: Colors.purple,
                    onclick: () {
                      createData();
                    },
                  ),
                  Button(
                    Buttontext: "Read",
                    color: Colors.green,
                    onclick: () {
                      setState(() {
                        isShow = true;
                      });
                    },
                  ),
                  Button(
                    Buttontext: "Update",
                    color: Colors.blue,
                    onclick: () {
                      updateData();
                    },
                  ),
                  Button(
                    Buttontext: "Delete",
                    color: Colors.red,
                    onclick: () {
                      deleteData();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ShowData(
                    type: "Name",
                    isHeading: true,
                  ),
                  ShowData(
                    type: "Student ID",
                    isHeading: true,
                  ),
                  ShowData(
                    type: "Student Program",
                    isHeading: true,
                  ),
                  ShowData(
                    type: "CGPA",
                    isHeading: true,
                  ),
                ],
              ),
              isShow
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Student")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> usermap =
                                      snapshot.data!.docs[index].data()
                                          as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        ShowData(type: usermap["Name"]),
                                        ShowData(type: usermap["Student ID"]),
                                        ShowData(
                                            type: usermap["Student Program"]),
                                        ShowData(type: usermap["CGPA"]),
                                      ],
                                    ),
                                  );
                                  // return ListTile(
                                  //     title: Text(usermap["Name"]),
                                  //     subtitle: Text(usermap["Student ID"] +
                                  //         " " +
                                  //         usermap["Student Program"]),
                                  //     trailing: Text(usermap["CGPA"]));
                                },
                              ),
                            );
                          } else {
                            return Text("No data");
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Click read to Display Data",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
            ]),
          ),
        ),
      ),
    );
  }
}