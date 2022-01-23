import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int finalScore;
  final VoidCallback resetHandler;

  const Result({Key? key, required this.finalScore, required this.resetHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Score ' '$finalScore',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: resetHandler,
              child: const Text(
                "Start Over",
              ),

            )
          ],
        )
      )
    );
  }
}
