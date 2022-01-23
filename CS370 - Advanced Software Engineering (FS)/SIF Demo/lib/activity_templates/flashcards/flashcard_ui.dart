import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sif_book/globals/globals.dart';
import 'flashcard.dart';

class FlashcardUI extends StatefulWidget {
  final dynamic flashcardJSON;
  final int lessonIndex;

  const FlashcardUI(
      {Key? key, required this.flashcardJSON, required this.lessonIndex})
      : super(key: key);

  @override
  _FlashcardUIState createState() => _FlashcardUIState();
}

class _FlashcardUIState extends State<FlashcardUI> {
  int _index = 0;
  String generalImg = 'assets/images/cerebrillo.png';

  void _showToast() {
    Fluttertoast.showToast(
        msg: "Short and Long Term Memory",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
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
          backgroundColor: sifBlue),
      appBar: AppBar(title: const Text('Vocabulary Practice')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                // Used for the image display on the flashcard activity
                width: 400,
                height: 100,
                child: Image.asset(widget.flashcardJSON[_index]['Path'])),
            SizedBox(
                width: 400,
                height: 250,
                child: FlipCard(
                  // The front/back text for the flashcards
                  front:
                      Flashcard(text: widget.flashcardJSON[_index]['Question']),
                  back: Flashcard(text: widget.flashcardJSON[_index]['Answer']),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              OutlinedButton.icon(
                  onPressed: goBackward,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Back')),
              OutlinedButton.icon(
                  onPressed: goForward,
                  icon: const Icon(Icons.chevron_right),
                  label: const Text('Next')),
            ])
          ],
        ),
      ),
    );
  }

  // Ideally these methods are contained outside the UI class, but it works fine.
  // These methods loop back around.
  void goForward() {
    setState(() {
      _index = (_index + 1 < widget.flashcardJSON.length) ? _index + 1 : 0;
      // Because of the wrapping above, we check when the index is back at 0.
      if (_index == 0) {
        lessonsComplete = widget.lessonIndex + 1;
      }
    });
  }

  void goBackward() {
    setState(() {
      _index =
          (_index - 1 >= 0) ? _index - 1 : (widget.flashcardJSON.length - 1);
    });
  }
}
