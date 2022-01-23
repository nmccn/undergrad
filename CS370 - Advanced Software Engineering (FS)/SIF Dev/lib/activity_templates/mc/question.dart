import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;

  const Question({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Text(
        question,
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 22)
      )
    );
  }
}
