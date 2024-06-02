
// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StudentRecordPage extends StatefulWidget {

  @override
  State<StudentRecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<StudentRecordPage> {

  late String name, studentID, studentProgram, cgpa;

  getName(name) {
    this.name = name;
  }
  getStudentID(studentID) {
    this.studentID = studentID;
  }
  getStudentProgram(studentProgram) {
    this.studentProgram = studentProgram;
  }
  getCGPA(cgpa) {
    this.cgpa = cgpa;
  }

  createData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('StudentRecord').
    doc(name);
    Map<String, dynamic> students = {
      'name': name,
      'studentID': studentID,
      'studentProgram': studentProgram,
      'cgpa': cgpa
    };
    documentReference.set(students).whenComplete( () {
      print("$name created");
    });
  }

  readData() {

    DocumentReference documentReference = FirebaseFirestore.instance.collection('StudentRecord').
    doc(name);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot['name']);
      print(datasnapshot['studentID']);
      print(datasnapshot['studentProgram']);
      print(datasnapshot['cgpa']);
    });
    
  }

  updateData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('StudentRecord').
    doc(name);
    Map<String, dynamic> students = {
      'name': name,
      'studentID': studentID,
      'studentProgram': studentProgram,
      'cgpa': cgpa
    };

    documentReference.set(students).whenComplete( () {
      print("$name updated");
    });
  }

  deleteData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("StudentRecord").
    doc(name);

    documentReference.delete().whenComplete(() {
      print('$name deleted');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text('Student App')
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/icons/avatar.PNG",),
              minRadius: 90.0,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.redAccent,
                ),
                child: Text ('Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),)
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Image.asset('assets/icons/name.png',
                  scale: 4,),
                  hintText: 'Name'
              ),
              onChanged: (String name) {
                getName(name);
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Image.asset('assets/icons/studentID.png',
                    scale: 10,),
                  hintText: 'Student ID'
              ),
              onChanged: (String studentID) {
                getStudentID(studentID);
              },

            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Image.asset('assets/icons/student-program.png',
                    scale: 10,),
                  hintText: 'Student Program'
              ),
              onChanged: (String studentProgram) {
                getStudentProgram(studentProgram);
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Image.asset('assets/icons/cgpa.png',
                    scale: 10,),
                  hintText: 'CGPA'
              ),
              onChanged: (String cgpa) {
                getCGPA(cgpa);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Create'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      createData();
                    }
                  ),
                  ElevatedButton(
                      onPressed:() {
                    readData();
                  },
                      child: Text('Read'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      )
                  ),
                  ElevatedButton(
                      onPressed:() {
                    updateData();
                  },
                      child: Text('Update'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                      )
                  ),
                  ElevatedButton(
                      onPressed:() {
                    deleteData();
                  },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      )
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Text('Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                Spacer(),
                Text('Student ID',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                Spacer(),
                Text('Student Program',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                Spacer(),
                Text('CGPA',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),
        Expanded(
          child: StreamBuilder <QuerySnapshot> (
            stream: FirebaseFirestore.instance.collection('StudentRecord').
            snapshots(),
            builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData && snapshot.data != null) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          Map<String, dynamic> studentMap = snapshot.data!.
                          docs[index].data() as Map<String, dynamic>;

                          return Row(
                            children: [
                              Text(studentMap ['name'],
                                style: const TextStyle(
                                    color: Colors.deepPurple
                                ),),
                              Spacer(),
                              Text(studentMap ['studentID'],
                                style: const TextStyle(
                                    color: Colors.deepPurple
                                ),),
                              Spacer(),
                              Text(studentMap ['studentProgram'],
                                style: const TextStyle(
                                    color: Colors.deepPurple
                                ),),
                              Spacer(),
                              Text(studentMap ['cgpa'],
                                style: const TextStyle(
                                    color: Colors.deepPurple
                                ),),

                            ],
                          );

                        }
                    ),
                  );
                }
                else {
                  return Text('No Data');
                }
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

            },
          ),
        ),
          ]
        ),
      ),
    );
  }
}
