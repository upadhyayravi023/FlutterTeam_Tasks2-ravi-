import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String Buttontext;
  final Color color;
  final void Function()? onclick;

  const Button(
      {super.key, required this.Buttontext, required this.color, this.onclick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onclick,
        child: Text(
          Buttontext,
          style: TextStyle(fontSize: 12.9, color: Colors.white),
        ),
      ),
    );
  }
}
