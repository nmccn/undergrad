import 'dart:async';
import 'package:sif_book/activity_templates/conversations/conversation_ui.dart';
import 'package:sif_book/activity_templates/mc/multiplechoice_ui.dart';
import 'package:sif_book/activity_templates/neuroscience/neuroscience_ui.dart';
import 'package:sif_book/globals/globals.dart';
import 'package:flutter/material.dart';
import 'package:sif_book/globals/neuroscience_tips.dart';
import '../../globals/globals.dart';
import '../../activity_templates/flashcards/flashcard_ui.dart';

class Chapter2Lessons extends StatefulWidget {
  const Chapter2Lessons({Key? key}) : super(key: key);

  @override
  State<Chapter2Lessons> createState() => _Chapter2LessonsState();
}

class _Chapter2LessonsState extends State<Chapter2Lessons> {
  @override
// The widget being built here is the entire screen, and the body: ListWidget() creates an inner widget that is the list of Chapters.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(title: const Text('Lesson Selection')),
          body: const ListWidget(),
        ),
      ),
    );
  }
}
/*
    A lot of the code below here could be refactored or put into a loop to be a lot less repetitive, but it was more of a working test.
      - Lists of Names, icons, etc could be used and then we can just make the buttons in a loop or something.
 */

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("Neuroscience Page"),
            trailing: (lessonsComplete >= 1) ? unlocked : locked,
            selected: (lessonsComplete >= 1) ? true : false,
            enabled: (lessonsComplete >= 1) ? true : false,
            onTap: () {
              // Navigates to a temporary Activity page.
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const NeuroscienceUI(pageText: wiringTip)))
                  .then(onGoBack);
            },
          ),
          ListTile(
            title: const Text("Lesson 1:"),
            subtitle: const Text('Articulous Indefinidos'),
            trailing: (lessonsComplete >= 1) ? unlocked : locked,
            selected: (lessonsComplete >= 1) ? true : false,
            enabled: (lessonsComplete >= 1) ? true : false,
            onTap: () {
              // Navigates to a temporary Activity page.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultipleChoiceUI(
                            questions: ch2MultipleChoice1,
                          ))).then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 2:'),
            subtitle: const Text('Preposiciones'),
            trailing: (lessonsComplete >= 2) ? unlocked : locked,
            selected: (lessonsComplete >= 2) ? true : false,
            enabled: (lessonsComplete >= 2) ? true : false,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlashcardUI(
                          flashcardJSON: ch2Flashcard1,
                          lessonIndex: 2))).then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 3:'),
            subtitle: const Text('Dialogue'),
            trailing: (lessonsComplete >= 3) ? unlocked : locked,
            selected: (lessonsComplete >= 3) ? true : false,
            enabled: (lessonsComplete >= 3) ? true : false,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConversationUI(
                          transcript: ch2Transcript1,
                          path: 'assets/audio/ch2-dialogue.mp3',
                          lessonIndex: 3))).then(onGoBack);
            },
          ),
        ],
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
