import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String studentName,studentID,studyProgramID;
  late double studentGPA;
  getStudentName(name){
    this.studentName=name;
  }
  getStudentGPA(gpa){
    this.studentGPA=double.parse(gpa);
  }
  getStudentID(id){
    this.studentID=id;
  }
  getStudyProgramID(programID){

    this.studyProgramID=programID;
  }

  createData(){
    print('created');
    DocumentReference documentReference = FirebaseFirestore.
    instance.collection('MyStudents').doc(studentName);
    Map<String,dynamic> students= {
      "studentName":studentName,
      "studentGPA":studentGPA,
      "studentID":studentID,
      "studyProgramID":studyProgramID,
    };
    documentReference.set(students).whenComplete(() => print("$studentName created"));
  }
  ReadData(){
    DocumentReference documentReference=FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    documentReference.get().then((snapshot){
      print(snapshot.data());
    });
  }
  updateData(){
    DocumentReference documentReference=FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    Map<String, dynamic> students= {
      "studentName":studentName,
      "studentGPA":studentGPA,
      "studentID":studentID,
      "studyProgramID":studyProgramID,
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName updated");
    });
  }
  deleteData() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection(
        "MyStudents").doc(studentName);
    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: const Text('Student App',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: 
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 11,),
            Image(image: AssetImage("assets/images/student.png"),height: 150,width: 150,),
            ElevatedButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
                   },
              child:Text('LogOut',style: TextStyle(color: Colors.white,fontSize: 20),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
              ),
            ),


            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,width: 1.0),
                  ),
                ),
                onChanged: (String name){
                  getStudentName(name);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,width: 2.0),
                  ),
                ),
                onChanged: (String id){
                  getStudentID(id);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Study Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,width: 2.0),
                  ),
                ),
                onChanged: (String programID){
                  getStudyProgramID(programID);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "CGPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,width: 2.0),
                  ),
                ),
                onChanged: (String gpa){
                  getStudentGPA(gpa);
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: Text('create',style: TextStyle(color: Colors.white),),
                  onPressed:(){
                    createData();
                  },
        
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Read',style: TextStyle(color: Colors.white),),
                  onPressed:(){
                    ReadData();
                  },
        
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('update',style: TextStyle(color: Colors.white),),
                  onPressed:(){
                    updateData();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('delete',style: TextStyle(color: Colors.white),),
                  onPressed:(){
                    deleteData();
                  },
                ),
              ],
            ),
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("MyStudents").snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index){
                          DocumentSnapshot documentSnapshot=snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                          return Row(
                            children: [
                              Expanded(
                                  child: Text(documentSnapshot["studentName"])
                              ),
                              Expanded(
                                  child: Text(documentSnapshot["studentID"])
                              ),
                              Expanded(
                                  child: Text(documentSnapshot["studyProgramID"])
                              ),
                              Expanded(
                                  child: Text(documentSnapshot["studentGPA"].toString())
                              ),

                            ],
                          );
                        },
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index){
                        return Row(
                          children: [
                            Text("No Data")
                          ],
                        );
                      },
                    );
                  }
              ),
          )
        
          ],
        ),
      ),

    );
  }
}
