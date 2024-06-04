import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/student_data.dart';
import '../services/database_service.dart';
import '../utils/utils.dart';
import '../activity/loginScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _studentIdcontroller = TextEditingController();
  final TextEditingController _studentProgramcontroller = TextEditingController();
  final TextEditingController _cgpacontroller = TextEditingController();
  final DatabaseServices _databaseServices = DatabaseServices();
  final ValueNotifier<bool> _studentview = ValueNotifier<bool>(false);
  final ValueNotifier<String> _docId = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Center(child: Text("Student App",style: TextStyle(fontWeight: FontWeight.bold),)),
          elevation: 8.0,
          shadowColor: Colors.black,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                const Center(
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage("assets/icons/avatar.png"),
                  ),
                ),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: (){
                    logout(context);
                  },
                  child: _logoutbtn(context),
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  controller: _namecontroller,
                  keyboardType: TextInputType.text,
                  enabled: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter Name";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Name",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 1,
                        child: Image.asset("assets/icons/boy.png"),
                      ),
                    ),

                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _studentIdcontroller,
                  keyboardType: TextInputType.number,
                  enabled: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter ID";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Student ID",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 1,
                        child: Image.asset("assets/icons/id-card.png"),
                      ),
                    ),

                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _studentProgramcontroller,
                  keyboardType: TextInputType.text,
                  enabled: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter Department";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Student Program",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 1,
                        child: Image.asset("assets/icons/education.png"),
                      ),
                    ),

                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: _cgpacontroller,
                  keyboardType: TextInputType.number,
                  enabled: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter CGPA";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue,width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "CGPA",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 1,
                        child: Image.asset("assets/icons/badge.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        _addStudent();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Create",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _studentview.value = !_studentview.value;
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.green.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Read",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _updateStudent();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Update",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _deleteStudent();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.red.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Delete",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Name",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    Text("Student ID",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    Text("Student\nProgram",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    Text("CGPA",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                  ],
                ),
                const SizedBox(height: 15,),
                ValueListenableBuilder(valueListenable: _studentview
                    , builder: (context, isstudentview, child){
                  return isstudentview ? _displayData(context): _blankview(context);
                    }),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ),

      ),
    );
  }
  void logout(BuildContext context){
    _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      Utils().toastMessage("LogOut Successfully!", Colors.green.shade400);
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString(), Colors.red.shade400);
    });
  }

  Widget _logoutbtn(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.height * 0.065,
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(child: Text("Log Out", style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w400),)),
    );
  }

 

  Widget _displayData(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: _databaseServices.getStudent(),
          builder: (context, snapshot){

            List students = snapshot.data?.docs ?? [];
            if(students.isEmpty){
              return const Center(
                child: Text("Add Student Data", style: TextStyle(color: Colors.black,fontSize: 15),),
              );
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return const SizedBox(
                height: 200,
                width: 200,
                child:  CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3.0,
                )
              );
            }
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index){
                StudentData student = students[index].data();
                String studentdocId = students[index].id;

                return InkWell(
                  onTap: (){
                    _editStudentInfo(context, studentdocId, student);
                  },
                  child: Card(
                    color: Colors.grey.shade300,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(student.name,),
                          ),
                          Text(student.studentId.toString()),
                          Text(student.studentProgram),
                          Text(student.cgpa.toString())
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          })
    );
  }

  Widget _blankview(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade300,
      child: const Center(child: Text("Click 'Read' to Fetch Info.",style: TextStyle(color: Colors.black,fontSize: 18),),),
    );
  }

 void _addStudent(){
    StudentData studentData = StudentData(
        name: _namecontroller.text.toString(),
        studentId: int.parse(_studentIdcontroller.text),
        studentProgram: _studentProgramcontroller.text.toString().toUpperCase(),
        cgpa: double.parse(_cgpacontroller.text));
    _databaseServices.addStudent(studentData);

    _namecontroller.clear();
    _studentIdcontroller.clear();
    _studentProgramcontroller.clear();
    _cgpacontroller.clear();
  }

  void _editStudentInfo(BuildContext context, String studentdocId, StudentData student){
    _namecontroller.text = student.name;
    _studentIdcontroller.text = student.studentId.toString();
    _studentProgramcontroller.text = student.studentProgram;
    _cgpacontroller.text = student.cgpa.toString();
    _docId.value = studentdocId;
  }

  void _updateStudent(){
    StudentData updatedstudentdata = StudentData(
        name: _namecontroller.text.toString(),
        studentId: int.parse(_studentIdcontroller.text),
        studentProgram: _studentProgramcontroller.text.toString().toUpperCase(),
        cgpa: double.parse(_cgpacontroller.text));
    _databaseServices.updateStudent(_docId.value, updatedstudentdata);
  }

  void _deleteStudent(){
    _databaseServices.deleteStudent(_docId.value);
    _namecontroller.clear();
    _studentIdcontroller.clear();
    _studentProgramcontroller.clear();
    _cgpacontroller.clear();
  }
}
