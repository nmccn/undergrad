import 'dart:async';
import 'package:sif_book/activity_templates/conversations/conversation_ui.dart';
import 'package:sif_book/activity_templates/mc/multiplechoice_ui.dart';
import 'package:sif_book/activity_templates/neuroscience/neuroscience_ui.dart';
import 'package:sif_book/globals/globals.dart';
import 'package:flutter/material.dart';
import 'package:sif_book/globals/neuroscience_tips.dart';
import '../../globals/globals.dart';
import '../../activity_templates/flashcards/flashcard_ui.dart';

class Chapter1Lessons extends StatefulWidget {
  const Chapter1Lessons({Key? key}) : super(key: key);

  @override
  State<Chapter1Lessons> createState() => _Chapter1LessonsState();
}

class _Chapter1LessonsState extends State<Chapter1Lessons> {
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
                              const NeuroscienceUI(pageText: exerciseTip)))
                  .then(onGoBack);
            },
          ),
          ListTile(
            title: const Text("Lesson 0:"),
            subtitle: const Text('Demo Flashcards'),
            trailing: (lessonsComplete >= 1) ? unlocked : locked,
            selected: (lessonsComplete >= 1) ? true : false,
            enabled: (lessonsComplete >= 1) ? true : false,
            onTap: () {
              // Navigates to a temporary Activity page.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlashcardUI(
                          flashcardJSON:
                              ch1DemoFlashcardResponse, // Declare which global flashcardResponse is being used for the activity
                          lessonIndex: 1))).then(onGoBack);
            },
          ),
          ListTile(
            title: const Text("Lesson 1:"),
            subtitle: const Text('Alphabet Flashcards'),
            trailing: (lessonsComplete >= 1) ? unlocked : locked,
            selected: (lessonsComplete >= 1) ? true : false,
            enabled: (lessonsComplete >= 1) ? true : false,
            onTap: () {
              // Navigates to a temporary Activity page.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlashcardUI(
                          flashcardJSON: ch1FlashCardResponse1,
                          lessonIndex: 1))).then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 2:'),
            subtitle: const Text('Vocabulary Flashcards'),
            trailing: (lessonsComplete >= 2) ? unlocked : locked,
            selected: (lessonsComplete >= 2) ? true : false,
            enabled: (lessonsComplete >= 2) ? true : false,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlashcardUI(
                            flashcardJSON: ch1FlashCardResponse2,
                            lessonIndex: 2,
                          ))).then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 3:'),
            subtitle: const Text('Conjugated Forms Flashcards'),
            trailing: (lessonsComplete >= 3) ? unlocked : locked,
            selected: (lessonsComplete >= 3) ? true : false,
            enabled: (lessonsComplete >= 3) ? true : false,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlashcardUI(
                          flashcardJSON: ch1FlashCardResponse3,
                          lessonIndex: 3))).then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 4:'),
            subtitle: const Text('Descriptive Adjectives Multiple Choice'),
            trailing: (lessonsComplete >= 4) ? unlocked : locked,
            selected: (lessonsComplete >= 4) ? true : false,
            enabled: (lessonsComplete >= 4) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MultipleChoiceUI(questions: ch1MultipleChoice1)))
                  .then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 5:'),
            subtitle: const Text('Definite Article Multiple Choice'),
            trailing: (lessonsComplete >= 5) ? unlocked : locked,
            selected: (lessonsComplete >= 5) ? true : false,
            enabled: (lessonsComplete >= 5) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MultipleChoiceUI(questions: ch1MultipleChoice2)))
                  .then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 6:'),
            subtitle: const Text('Ser Conjugation Multiple Choice'),
            trailing: (lessonsComplete >= 6) ? unlocked : locked,
            selected: (lessonsComplete >= 6) ? true : false,
            enabled: (lessonsComplete >= 6) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MultipleChoiceUI(questions: ch1MultipleChoice3)))
                  .then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 7:'),
            subtitle: const Text('Singular Articles Multiple Choice'),
            trailing: (lessonsComplete >= 7) ? unlocked : locked,
            selected: (lessonsComplete >= 7) ? true : false,
            enabled: (lessonsComplete >= 7) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MultipleChoiceUI(questions: ch1MultipleChoice4)))
                  .then(onGoBack);
            },
          ),
          ListTile(
            title: const Text('Lesson 8:'),
            subtitle: const Text('Dialogue'),
            trailing: (lessonsComplete >= 8) ? unlocked : locked,
            selected: (lessonsComplete >= 8) ? true : false,
            enabled: (lessonsComplete >= 8) ? true : false,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConversationUI(
                          transcript: ch1AudioTranscript,
                          path: 'assets/audio/ch1-dialogue.mp3',
                          lessonIndex: 8))).then(onGoBack);
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
