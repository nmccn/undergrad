import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../globals/globals.dart';
import './quiz.dart';
import './result.dart';

class MultipleChoiceUI extends StatefulWidget {
  final dynamic questions;
  const MultipleChoiceUI({Key? key, required this.questions}) : super(key: key);

  @override
  _MultipleChoiceUIState createState() => _MultipleChoiceUIState();
}

class _MultipleChoiceUIState extends State<MultipleChoiceUI> {
  // Index the list of widget.questions, and keep track of the player's score.
  int _index = 0;
  int _totalScore = 0;

  void _startOver() {
    setState(() {
      _index = 0;
      _totalScore = 0;
    });
  }

  void _findAnswer(int score) {
    _totalScore += score;
    // If the score is 1, we can move on to the next question.
    // If it is 0, we will want to notify the user and have them guess again.
    if (score == 0) {
      Fluttertoast.showToast(
          msg: "Oops- that's not correct. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        // TODO
        // Make sure the index doesn't go out of bounds.
        if (_index < widget.questions.length - 1) {
          _index += 1;
        } else {
          _index = 0;
        }
      });
    }
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: "Attention & Wiring",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: sifOrange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showToast,
          label: const Text('Neuroscience Tip'),
          backgroundColor: sifBlue,
        ),
        appBar: AppBar(title: const Text("Multiple_Choice")),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                // For the MC image at the top (BPL logo)
                Container(
                    width: 100,
                    height: 75,
                    alignment: Alignment.topCenter,
                    child: Image.asset("assets/images/bpl_Logo.png")),

                // For the activity segment
                Container(
                  height: MediaQuery.of(context).size.height - 400,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: _index < widget.questions.length
                      ? Quiz(
                          index: _index,
                          questionJSON: widget.questions,
                          findAnswer: _findAnswer)
                      : Result(
                          finalScore: _totalScore, resetHandler: _startOver),
                ),

                // For the MC image at the bottom (Brain man)
                Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.bottomCenter,
                    margin:
                        EdgeInsets.only(left: 0, top: 30, right: 0, bottom: 0),
                    child: Image.asset("assets/images/cerebrillo.png")),
              ],
            )));
  }
}
