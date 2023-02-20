import 'package:flutter/material.dart';

class CustomALertDialog extends StatelessWidget {
  const CustomALertDialog({super.key, required this.title, required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(title), content: Text(text));
  }
}
