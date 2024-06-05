import 'package:flutter/material.dart';

class Cstextin {
  static CustomTextField(
      String infoicon, String placeholderText, Function funcName) {
    return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20, top:10),
        child: TextFormField(
            onChanged: (text) {
              funcName(text);
            },
            decoration: InputDecoration(

              hintText: placeholderText,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                 child: Image(
                    height: 25,
                    width: 25,
                    image: AssetImage(infoicon),
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

            )));
  }
}
