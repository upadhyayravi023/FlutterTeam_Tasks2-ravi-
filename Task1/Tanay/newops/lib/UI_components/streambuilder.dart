import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  static StreamBuilder<QuerySnapshot> datalist() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("mystudent").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Text("No Data");
        }

        final client = snapshot.data!.docs.toList().reversed;
        List<Row> clientWidgets = [];
        const clientWidget = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.w600),
            )),
            Expanded(
                child: Text("Roll No.",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            Expanded(
                child: Text("Study \nProgram",
                    style: TextStyle(fontWeight: FontWeight.w600))),
            Expanded(
                child: Text("CGPA",
                    style: TextStyle(fontWeight: FontWeight.w600))),
          ],
        );
        clientWidgets.add(clientWidget);
        for (var mystudent in client) {
          final clientWidget = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(mystudent['studentName'])),
              Expanded(child: Text(mystudent['studentRoll'])),
              Expanded(child: Text(mystudent['studyProgram'])),
              Expanded(child: Text(mystudent['gpa'])),
            ],
          );
          clientWidgets.add(clientWidget);
        }

        return ListView(
          children: clientWidgets,
        );
      },
    );
  }
}
