import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app_adi/Screens/LoginPage.dart';
import 'package:crud_app_adi/Widgets/HomeTable.dart';
import 'package:crud_app_adi/Widgets/HomeTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController studentId = TextEditingController();
  TextEditingController cgpa = TextEditingController();
  TextEditingController studentProgram = TextEditingController();
  var isShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student App",
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 80,
                    foregroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                    },
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        alignment: Alignment.center,
                        height: 42,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          color: Colors.red,
                        ),
                        child: const Text(
                          "LogOut",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  HomeTextField(
                      hintText: "Name",
                      icon: "assets/images/name.png",
                      textEditingController: name),
                  SizedBox(
                    height: 20,
                  ),
                  HomeTextField(
                      hintText: "Student ID",
                      icon: "assets/images/student_id.png",
                      textEditingController: studentId),
                  SizedBox(
                    height: 20,
                  ),
                  HomeTextField(
                      hintText: "Student Program",
                      icon: "assets/images/student_program.png",
                      textEditingController: studentProgram),
                  SizedBox(
                    height: 20,
                  ),
                  HomeTextField(
                      hintText: "CGPA",
                      icon: "assets/images/cgpa.png",
                      textEditingController: cgpa),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (studentId.text.isNotEmpty) {
                            createData(name.text, studentProgram.text,
                                studentId.text, cgpa.text);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Kindly enter student id"),
                            ));
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 42,
                            width: 90,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.deepPurpleAccent,
                            ),
                            child: const Text(
                              "Create",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isShow = true;
                          });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 42,
                            width: 90,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.green,
                            ),
                            child: const Text(
                              "Read",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          updateData(name.text, studentProgram.text,
                              studentId.text, cgpa.text);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 42,
                            width: 90,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue,
                            ),
                            child: const Text(
                              "Update",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (studentId.text.isNotEmpty) {
                            deleteData(studentId.text);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("kindly enter student id"),
                            ));
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 42,
                            width: 90,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.red,
                            ),
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("Student ID",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("Student \nProgram",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("CGPA",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
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
                                return Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> student =
                                          snapshot.data!.docs[index].data()
                                              as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: HomeTable(
                                          name: student['name'],
                                          studentId: student['id'],
                                          studentProgram: student['program'],
                                          cgpa: student['cgpa'],
                                        ),
                                      );
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createData(String name, String program, String id, String cgpa) async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(id);

    Map<String, dynamic> studentData = {
      "name": name,
      "id": id,
      "program": program,
      "cgpa": cgpa,
    };
    documentReference
        .set(studentData)
        .whenComplete(() => {print("Database Created Sucessfully")});
  }

  readData() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc();

    documentReference.get().whenComplete(() => {print("Read Sucessfully")});
  }

  updateData(String name, String program, String id, String cgpa) async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(id);

    Map<String, dynamic> studentData = {
      "name": name,
      "id": id,
      "program": program,
      "cgpa": cgpa,
    };

    documentReference
        .update(studentData)
        .whenComplete(() => {print("Updated Sucessfully")});
  }

  deleteData(String id) async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection("Student").doc(id);

    documentReference
        .delete()
        .whenComplete(() => {print("Deleted Sucessfully")});
  }
}
