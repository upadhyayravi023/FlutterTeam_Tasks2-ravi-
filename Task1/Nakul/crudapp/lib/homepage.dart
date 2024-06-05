import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:crudapp/firebase_auth.dart';
import 'package:crudapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final User? user=Auth().currentUser;

  Future<void> signOut() async{
    await Auth().signOut();
  }


  late String studentName, studentID , studyProgramID;
  late String studentGPA;

  getStudentName(name){
    this.studentName=name;
  }

  getStudentID(id){
    this.studentID=id;
  }

  getStudyProgramID(programID){
    this.studyProgramID=programID;

  }

  getStudentGPA(gpa){
    this.studentGPA=gpa;
  }

  createData(){
   
  
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studentProgramID": studyProgramID,
      "studentGPA": studentGPA
    };
    documentReference.set(students).whenComplete(() => 
      print("$studentName created"),

    );
    
  }
   readData(){
    DocumentReference db = FirebaseFirestore.instance.collection("MyStudents").doc("studentName");
    
    db.collection("MyStudents").get().then(
  (querySnapshot) {
    print("Successfully completed");
    for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
    }
  },
  onError: (e) => print("Error completing: $e"),
);
   
  }
    updateData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studentProgramID": studyProgramID,
      "studentGPA": studentGPA
    };
    documentReference.set(students).whenComplete(() => 
      print("$studentName updated"),

    );
  }
  deleteData(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }
    TextEditingController username= new TextEditingController();
    TextEditingController userid= new TextEditingController();
    TextEditingController userprog= new TextEditingController();
    TextEditingController usercg= new TextEditingController();
    bool isVisible=false;

  @override
  Widget build(BuildContext context) {
    final _width=MediaQuery.of(context).size.width;
    final _height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.yellow,
        title: Center(
          child: Container(
            child: Text("Student App",style: TextStyle(fontWeight: FontWeight.w500,),),
           
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
           
            child: Column(
             
              children: [
                SizedBox(height: 20,),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 67,
                  
                  backgroundImage: AssetImage("assets/images/student.png"),
                ),
                SizedBox(height: 20,),
                Container(
                  
                  child: ElevatedButton(onPressed: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                  }, 
                  child: Text("LogOut",style: TextStyle(color: Colors.white,fontSize: 20 ,),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  ),
                ),
                SizedBox(height: 15,),
                
                SizedBox(
      height: 75,
      width: 320,
      
      child: TextField(
          controller: username,
        cursorColor: Colors.lightBlue,
        style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          hintText: " Name",
          
          prefixIcon: Image(image: AssetImage("assets/images/pro.png"),height: 19,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.blue,
            )
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
            )
          ),
        ),
        onChanged: (String name){
          getStudentName(name);
        },
      ),

    ),
                
                
                 
       SizedBox(
      height: 75,
      width: 320,
      
      child: TextField(
        controller: userid,
        cursorColor: Colors.lightBlue,
        style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          hintText: "  Student ID",
          
          prefixIcon: Image(image: AssetImage("assets/images/card.png"),height: 19,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.blue,
            )
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
            )
          ),
        ),
        onChanged: (String id){
          getStudentID(id);
        },
      ),

    ),
                 
                 
       SizedBox(
      height: 75,
      width: 320,
      
      child: TextField(
        controller: userprog,
        cursorColor: Colors.lightBlue,
        style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          hintText: "Student Program",
          
          prefixIcon: Image(image: AssetImage("assets/images/program.png"),height: 19,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.blue,
            )
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
            )
          ),
        ),
         onChanged: (String programID){
          getStudyProgramID(programID);
        },
      ),

    ),
                 
                 
       SizedBox(
      height: 75,
      width: 320,
      
      child: TextField(
        controller: usercg ,
        cursorColor: Colors.lightBlue,
        style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          hintText: "CGPA",
          
          prefixIcon: Image(image: AssetImage("assets/images/cgp.png"),height: 19,),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.blue,
            )
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.grey,
            )
          ),
        ),
        onChanged: (String gpa){
          getStudentGPA(gpa);
        },
      ),

    ),
   SizedBox(height:10,),
                 Row(
                  children: [
                    Container(
                      width: 90,
                      height: 47,
                      child: ElevatedButton(onPressed: (){
                        createData();
                      }, child: Text("Create",style: TextStyle(color: Colors.white,fontSize: 14 ,),),
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                        
                      ),
                      ),),
                      Container(
                      width: 81,
                      height: 47,
                      child: ElevatedButton(onPressed: (){
                        readData();
                        setState(() {
                        isVisible=!isVisible;
                          
                        });
                      }, child: Text("Read",style: TextStyle(color: Colors.white,fontSize: 14 ,),),
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)
                      )
                        
                      ),
                      ),),
                      Container(
                      width: 94,
                      height: 47,
                      child: ElevatedButton(onPressed: (){
                        updateData();
                      }, child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 14 ,),),
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)
                      )
                        
                      ),
                      ),),
                      Container(
                      width: 90,
                      height: 47,
                      child: ElevatedButton(onPressed: (){
                        deleteData();
                      }, child: Text("Delete",style: TextStyle(color: Colors.white,fontSize: 14,),),
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)
                      )
                        
                      ),
                      ),
                ),
                  ],
                 ),
                SizedBox(height: 10,),
                     
                     isVisible? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(child: Text("Name",style: TextStyle(fontWeight: FontWeight.w700),)),
                            Expanded(child: Text("Student ID",style: TextStyle(fontWeight: FontWeight.w700),)),
                            Expanded(child: Text("Student Program",style: TextStyle(fontWeight: FontWeight.w700),)),
                            Expanded(child: Text("CGPA",style: TextStyle(fontWeight: FontWeight.w700),)),
                            
                          ],),
                           StreamBuilder(stream: FirebaseFirestore.instance.collection("MyStudents").snapshots(), builder: (context,snapshot){
                     if(snapshot.hasData){
                      return ListView.builder(
                         scrollDirection: Axis.vertical,
                         shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        
                        itemBuilder: (context,index){
                          DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                          return Row(
                            children: [
                              Expanded(child: Text(documentSnapshot["studentName"]),  
                              ),
                              Expanded(child: Text(documentSnapshot["studentID"]),  
                              ),
                              Expanded(child: Text(documentSnapshot["studentProgramID"]),  
                              ),
                              Expanded(child: Text(documentSnapshot["studentGPA"]),  
                              ),
                            ],
                          );
                          

                        });
                        
                     }
                     else{
                      return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator(color: Colors.blue,),
                      );
                     }
                },)

                        ],
                      ),
                    )
                   :Text("Click Read to see Students list") 

              ],
            ),

          ),
        ),
      ),
    );
  }
}