import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
  const FormText({super.key, required this.label, required this.isPassword});
  final String label;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.deepPurple[900]),
        filled: true,
        fillColor: Colors.deepPurple[50],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.deepPurple[700]!, width: 2)),
      ),
    );
  }
}
