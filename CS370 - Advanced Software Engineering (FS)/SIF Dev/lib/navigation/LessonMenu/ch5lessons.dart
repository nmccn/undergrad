import 'dart:async';
import 'package:sif_book/activity_templates/conversations/conversation_ui.dart';
import 'package:sif_book/activity_templates/mc/multiplechoice_ui.dart';
import 'package:sif_book/activity_templates/neuroscience/neuroscience_ui.dart';
import 'package:sif_book/globals/globals.dart';
import 'package:flutter/material.dart';
import 'package:sif_book/globals/neuroscience_tips.dart';
import '../../globals/globals.dart';
import '../../activity_templates/flashcards/flashcard_ui.dart';

class Chapter5Lessons extends StatefulWidget {
  const Chapter5Lessons({Key? key}) : super(key: key);

  @override
  State<Chapter5Lessons> createState() => _Chapter5LessonsState();
}

class _Chapter5LessonsState extends State<Chapter5Lessons> {
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
                              const NeuroscienceUI(pageText: plasticityTip)))
                  .then(onGoBack);
            },
          ),
          ListTile(
            title: const Text("Lesson 1:"),
            subtitle: const Text('Vacation Vocab Flashcards'),
            trailing: (lessonsComplete >= 1) ? unlocked : locked,
            selected: (lessonsComplete >= 1) ? true : false,
            enabled: (lessonsComplete >= 1) ? true : false,
            onTap: () {
              // Navigates to a temporary Activity page.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlashcardUI(
                          flashcardJSON: ch5FlashCardResponse1,
                          lessonIndex: 1))).then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 2:'),
            subtitle: const Text('Nationalities Multiple Choice'),
            trailing: (lessonsComplete >= 2) ? unlocked : locked,
            selected: (lessonsComplete >= 2) ? true : false,
            enabled: (lessonsComplete >= 2) ? true : false,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultipleChoiceUI(
                            questions: ch5MCResponse1,
                          ))).then(onGoBack);
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
