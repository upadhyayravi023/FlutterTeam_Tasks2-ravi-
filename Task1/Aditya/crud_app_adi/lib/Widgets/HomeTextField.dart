import 'package:flutter/material.dart';
class HomeTextField extends StatefulWidget {
  final String hintText;
  final String icon;
  final TextEditingController textEditingController;
  const HomeTextField({super.key, required this.hintText, required this.icon, required this.textEditingController});

  @override
  State<HomeTextField> createState() => _HomeTextFieldState();
}

class _HomeTextFieldState extends State<HomeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Image(
                height: 25,
                width: 25,
                image: AssetImage(widget.icon),
              )
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),

        ));
  }
}
