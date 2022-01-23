import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final VoidCallback stateHandler;

  //Answer(this.answer, this.stateHandler);
  const Answer({Key? key, required this.answer, required this.stateHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Handle pressing the button
      onPressed: stateHandler, // Send the call up (we believe)
      child: Text(answer, style: const TextStyle(fontSize: 22)),
    );
  }
}
