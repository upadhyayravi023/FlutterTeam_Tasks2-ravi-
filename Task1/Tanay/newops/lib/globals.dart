import 'package:cloud_firestore/cloud_firestore.dart';

class Globals {
  static late String studentName;
  static late String studentRoll;
  static late String studyProgram;
  static String collection_name = "mystudent";
  static late String gpa;
  static bool show = false;

  final db = FirebaseFirestore.instance;
  static getName(String text) {
    studentName = text;
  }

  static getstudentRoll(String rollnum) {
    studentRoll = rollnum;
  }

  static getstudyProgram(String text) {
    studyProgram = text;
  }

  static getgpa(String text) {
    gpa = text;
  }

  static create(
      String name, String roll, String program, String cgpa, db) async {
    final user = <String, dynamic>{
      "studentName": name,
      "studentRoll": roll,
      "studyProgram": program,
      "gpa": cgpa,
    };
    db
        .collection("mystudent")
        .doc(name)
        .set(user)
        .onError((e, _) => print("Error writing document: $e"));
  }

  static update(
      String name, String roll, String program, String cgpa, db) async {
    print(name);

    final user = <String, dynamic>{
      "studentName": name,
      "studentRoll": roll,
      "studyProgram": program,
      "gpa": cgpa,
    };
    db
        .collection("mystudent")
        .doc(name)
        .set(user)
        .onError((e, _) => print("Error writing document: $e"));
  }

  static delete(String name, db) async {
    db.collection("mystudent").doc(name).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}
