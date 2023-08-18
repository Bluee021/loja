import "package:flutter/material.dart";
import "package:flutter/rendering.dart";

class Input extends StatelessWidget {
  Input(
      {super.key,
      required this.controller,
      required this.hintText,
      this.ocultar = false,
      this.inputType = TextInputType.text});

  final TextEditingController controller;
  bool ocultar;
  TextInputType inputType;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        obscureText: ocultar,
        keyboardType: inputType,
        decoration: InputDecoration(
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
