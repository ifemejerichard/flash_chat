import 'package:flutter/material.dart';

class Rbutton extends StatelessWidget {

  final VoidCallback inputGesture;
  final String inputText;

  const Rbutton({super.key, required this.inputGesture, required this.inputText});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: inputGesture,
      minWidth: 200.0,
      height: 42.0,
      child: Text(
        inputText,
      ),
    );
  }
}
