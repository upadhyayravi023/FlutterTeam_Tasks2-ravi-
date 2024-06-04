import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controllar;
  final String Field;
  final String icon;
  final void Function(String)? change;

  const InputBox(
      {super.key,
      required this.Field,
      required this.icon,
      required this.controllar,
      this.change});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: TextFormField(
        controller: controllar,
        onChanged: change,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: Field,
            hintStyle: TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 5, right: 8),
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Image.asset("assets/images/${icon}")),
            )),
      ),
    );
  }
}
