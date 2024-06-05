import 'dart:math';
import 'package:crud_app/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _showStreamBuilder = false;
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  late String studentName, studentID, studyProgramID;
  late double studentCGPA;
  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getStudyProgramID(programID) {
    this.studyProgramID = programID;
  }

  getStudentCGPA(cgpa) {
    this.studentCGPA = double.parse(cgpa);
  }

  createData() {
    print("created");
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _myStudentsCollection =
        _firestore.collection('Mystudents');
    final DocumentReference documentReference =
        _myStudentsCollection.doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentCGPA": studentCGPA
    };
    documentReference.set(students).whenComplete(() {
      print("$studentName created");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Mystudents").doc(studentName);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        // Cast data to a Map<String, dynamic>
        Map<String, dynamic> data = datasnapshot.data() as Map<String, dynamic>;

        // Access fields using the map
        String studentName = data["studentName"];
        String studentID = data["studentID"];
        String studyProgramID = data["studyProgramID"];
        double studentCGPA = data["studentCGPA"];

        // Print the retrieved data
        print("Student Name: $studentName");
        print("Student ID: $studentID");
        print("Study Program ID: $studyProgramID");
        print("Student CGPA: $studentCGPA");
      } else {
        print("Document does not exist");
      }
    }).catchError((error) {
      print("Error reading document: $error");
    });
  }

  updateData() {
    print("created");
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _myStudentsCollection =
        _firestore.collection('Mystudents');
    final DocumentReference documentReference =
        _myStudentsCollection.doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentCGPA": studentCGPA
    };
    documentReference.set(students).whenComplete(() {
      print("$studentName updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Mystudents").doc(studentName);
    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          'Student App',
          style: TextStyle(color: Colors.black, fontSize: 23),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/111111.jpg'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                width: 95,
                height: 40,
                child: ElevatedButton(
                  onPressed: (() => signout()),
                  child: Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                onChanged: (String name) {
                  getStudentName(name);
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "Name",
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  prefixIcon: SizedBox(
                      height: 11,
                      width: 10,
                      child:
                          Image(image: AssetImage('assets/images/lolo.png'))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: TextFormField(
                onChanged: (String id) {
                  getStudentID(id);
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "Student ID",
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  prefixIcon: SizedBox(
                      height: 10,
                      width: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 0),
                        child: Image(image: AssetImage('assets/images/id.jpg')),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: TextFormField(
                onChanged: (String programID) {
                  getStudyProgramID(programID);
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "Student Program",
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  prefixIcon: SizedBox(
                      height: 10,
                      width: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child:
                            Image(image: AssetImage('assets/images/cgu.png')),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: TextFormField(
                onChanged: (String cgpa) {
                  getStudentCGPA(cgpa);
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: "CGPA",
                  hintStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  prefixIcon: SizedBox(
                      height: 10,
                      width: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child:
                            Image(image: AssetImage('assets/images/poi.jpg')),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    createData();
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() => _showStreamBuilder = true);
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Read',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    updateData();
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    deleteData();
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    child: Text("Name"),
                  ),
                  Expanded(
                    child: Text("Student ID"),
                  ),
                  Expanded(
                    child: Text("Student Program"),
                  ),
                  Expanded(
                    child: Text("CGPA"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Mystudents")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                  documentSnapshot["studentName"].toString()),
                            ),
                            Expanded(
                              child: Text(
                                  documentSnapshot["studentID"].toString()),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["studyProgramID"]
                                  .toString()),
                            ),
                            Expanded(
                              child: Text(
                                  documentSnapshot["studentCGPA"].toString()),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
