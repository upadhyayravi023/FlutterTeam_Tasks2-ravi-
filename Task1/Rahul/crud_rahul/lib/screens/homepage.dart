import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';

class homepage extends StatefulWidget {

  @override
  State<homepage> createState() => _homepage();
}

class _homepage extends State<homepage> {

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
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Record').
    doc();
    Map<String, dynamic> students = {
      'name': name,
      'studentID': studentID,
      'studentProgram': studentProgram,
      'cgpa': cgpa,
    };
    documentReference.set(students).whenComplete( () {
      print("$name created");
    });
  }

  readData() {
    String documentId;
    FirebaseFirestore.instance.collection('Record').get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc){
        documentId = doc.id;
        DocumentReference documentReference = FirebaseFirestore.instance.collection('Record').doc(documentId);
        documentReference.get().then((DocumentSnapshot datasnapshot) {
          print(datasnapshot['name']);
          print(datasnapshot['studentID']);
          print(datasnapshot['studentProgram']);
          print(datasnapshot['cgpa']);
        });

      });
    });
  }

  updateData() {
    String documentId;
    FirebaseFirestore.instance.collection('Record').get().then((querySnapshot) {
      documentId = querySnapshot.docs.first.id;
      DocumentReference documentReference = FirebaseFirestore.instance.collection("Record").doc(documentId);

      Map<String, dynamic> students = {
        'name': name,
        'studentID': studentID,
        'studentProgram': studentProgram,
        'cgpa': cgpa
      };
      documentReference.set(students).whenComplete( () {
        print("$name updated");
      });
    });
  }

  deleteData() {
    String documentId;
    FirebaseFirestore.instance.collection('Record').get().then((querySnapshot) {
      documentId = querySnapshot.docs.first.id;
      DocumentReference documentReference = FirebaseFirestore.instance.collection("Record").doc(documentId);
      documentReference.delete().whenComplete(() {
        print('$name deleted');
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Student App',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
          backgroundColor: Colors.yellow,
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            SizedBox(height: 10,),

            ClipOval(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Color(0xff0072A3),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('Assets/Images/avatar.PNG'),
                  ),
                ),
              )
            ),

            SizedBox(height: 15,),

            ElevatedButton(onPressed: () {
              FirebaseAuth.instance.signOut().then((value)=>
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Loginpage())));
            },
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                    child: Text ('Log Out',style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)
            ),

            SizedBox(height: 10,),

            TextFormField(
              enabled: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                  hintText: 'Name',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height:45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('Assets/Images/name.png'),
                        ),
                      ),
                  ),
                ),

              ),
              onChanged: (String name) {
                getName(name);
              },
            ),

            SizedBox(height: 15,),

            TextFormField(
              enabled: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                  hintText: 'Student ID',
                  prefixIcon: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height:40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('Assets/Images/student-id.png'),
                  ),
                ),
              ),
            ),
              ),
              onChanged: (String studentID) {
                getStudentID(studentID);
              },

            ),
            SizedBox(height: 15,),
            TextFormField(
              enabled: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                  hintText: 'Student Program',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height:40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('Assets/Images/student program.png'),
                      ),
                    ),
                  ),
                ),
              ),
              onChanged: (String studentProgram) {
                getStudentProgram(studentProgram);
              },
            ),

            SizedBox(height: 15,),

            TextFormField(
              enabled: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.blue),
                  gapPadding: 2.0,
                ),
                  hintText: 'CGPA',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height:40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('Assets/Images/cgpa.png'),
                      ),
                    ),
                  ),
                ),
              ),
              onChanged: (String cgpa) {
                getCGPA(cgpa);
              },
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  SizedBox(
                    width: 82,
                    child: ElevatedButton(
                        child: Text('Create',style: TextStyle(fontSize: 18),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 2)
                        ),
                        onPressed: () {
                          createData();
                        }
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        onPressed:() {
                          readData();
                        },
                        child: Text('Read',style: TextStyle(fontSize: 18),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 2)
                        )
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        onPressed:() {
                          updateData();
                        },
                        child: Text('Update',style: TextStyle(fontSize: 18),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 2)
                        )
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        onPressed:() {
                          deleteData();
                        },
                        child: Text('Delete',style: TextStyle(fontSize: 18),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 2)
                        )
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 82,
                    child: Text(' Name', style: TextStyle(fontSize:18 , fontWeight: FontWeight.bold),)),

                SizedBox(
                    width: 82,
                    child: Text('Student ID', style: TextStyle(fontSize:18 , fontWeight: FontWeight.bold),)),

                SizedBox(
                    width: 82,
                    child: Text('Student Program', style: TextStyle(fontSize:18 , fontWeight: FontWeight.bold),)),

                SizedBox(
                    width: 82,
                    child: Text('   CGPA', style: TextStyle(fontSize:18 , fontWeight: FontWeight.bold),)),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder <QuerySnapshot> (
                stream: FirebaseFirestore.instance.collection('Record').
                snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.active) {
                    if(snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {

                            Map<String, dynamic> studentMap = snapshot.data!.
                            docs[index].data() as Map<String, dynamic>;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(studentMap ['name'], style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
                                Spacer(),
                                Text(studentMap ['studentID'], style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
                                Spacer(),
                                Text(studentMap ['studentProgram'], style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
                                Spacer(),
                                Text(studentMap ['cgpa']+"      ", style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),),
                              ],
                            );
                          }
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
          ],
        ),
      ),
    );
  }
}

