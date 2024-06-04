import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../model/student_data.dart';

const String STUDENT_COLLECTION_REF = 'students';

class DatabaseServices{
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference<StudentData> _studentcollectionref;

  DatabaseServices(){
    _studentcollectionref = _firestore.collection(STUDENT_COLLECTION_REF).withConverter<StudentData>(
        fromFirestore: (snapshots, _) => StudentData.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (studentdata, _) => studentdata.toJson());
  }

  Stream<QuerySnapshot> getStudent(){
    return _studentcollectionref.snapshots();
  }

  void addStudent(StudentData studentdata) async{
   await _studentcollectionref.add(studentdata).then((value) {
     Utils().toastMessage("Data Created!", Colors.green.shade400);
   }).onError((error, stackTrace) {
     Utils().toastMessage(error.toString(), Colors.red.shade400);
   });
  }

  void updateStudent(String studentdocId, StudentData studentdata) async{
    await _studentcollectionref.doc(studentdocId).update(studentdata.toJson()).then((value) {
      Utils().toastMessage("Data Updated!", Colors.green.shade400);
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString(), Colors.red.shade400);
    });
  }

  void deleteStudent(String studentdocId) async{
    await _studentcollectionref.doc(studentdocId).delete().then((value) {
      Utils().toastMessage("Data Deleted!", Colors.red.shade400);
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString(), Colors.red.shade400);
    });
  }
}