import 'package:flutter/material.dart';


class Datebox extends StatelessWidget{
  const Datebox({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context){
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
        child: Text(date),
      ),
    );
  }
}