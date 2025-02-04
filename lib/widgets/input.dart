import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  final String hintText;

  final TextEditingController textEditingController;
  // final IconData iconData;
  bool view = false;
  InputTextFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.view,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return TextFormField(
      cursorColor: const Color(0xff2A6443),
      style: TextStyle(
          fontFamily: 'FontMain',
          fontWeight: FontWeight.bold,
          fontSize: 15 * textScale),
      obscureText: view,
      controller: textEditingController,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        labelText: hintText,
        labelStyle: TextStyle(
            fontFamily: 'FontMain',
            color: Colors.blueGrey,
            fontSize: 15 * textScale,
            fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
