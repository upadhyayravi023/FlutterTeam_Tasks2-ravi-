import 'package:flutter/material.dart';
class HomeTable extends StatefulWidget {
  final String name;
  final String studentId;
  final String studentProgram;
  final String cgpa;
  const HomeTable({super.key, required this.name, required this.studentId, required this.studentProgram, required this.cgpa});

  @override
  State<HomeTable> createState() => _HomeTableState();
}

class _HomeTableState extends State<HomeTable> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(widget.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
        Text(widget.studentId,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
        Text(widget.studentProgram,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
        Text(widget.cgpa,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),)
      ],
    );
  }
}
