import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  final String text;
  const Flashcard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 55)))
    );
  }
}
