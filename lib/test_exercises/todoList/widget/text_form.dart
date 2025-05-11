import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm({super.key, this.title, this.controller, this.validator});
  final String? title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
      validator: validator,
    );
  }
}
