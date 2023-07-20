import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  final String buttonName;
  VoidCallback onPressed;

  Button({
    super.key, 
    required this.buttonName, 
    required this.onPressed});

  @override
  Widget build(Object context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.blue,
      child: Text(buttonName),
    );
  }

}