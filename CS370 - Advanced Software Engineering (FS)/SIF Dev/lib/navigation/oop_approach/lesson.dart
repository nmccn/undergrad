import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sif_book/activity_templates/conversations/conversation_ui.dart';
import 'package:sif_book/activity_templates/mc/multiplechoice_ui.dart';
import 'package:sif_book/activity_templates/neuroscience/neuroscience_ui.dart';
import 'package:sif_book/globals/neuroscience_tips.dart';
import '../../activity_templates/flashcards/flashcard_ui.dart';
import 'package:sif_book/globals/globals.dart';



class LessonButton extends StatefulWidget {
  // Similar to chapter.dart, variables that we will pass in when constructing each button.
  final int lessonIndex;
  final String title;
  final String subtitle;
  // lessonInfo is a LIST of lesson JSON
  final dynamic lessonInfo;

  const LessonButton({Key? key, required this.lessonIndex, required this.title, required this.subtitle, required this.lessonInfo}) : super(key: key);

  @override
  _LessonButtonState createState() => _LessonButtonState();
}

class _LessonButtonState extends State<LessonButton> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        trailing: (lessonsComplete >= widget.lessonIndex) ? unlocked  : locked,
        selected: (lessonsComplete >= widget.lessonIndex) ? true : false,
        enabled: (lessonsComplete >= widget.lessonIndex) ? true : false,
        onTap: () {
          // Navigate to Flashcard
          // Navigator.push(context, MaterialPageRoute(builder: (context) => FlashcardUI(flashcardJSON: widget.lessonInfo[widget.lessonIndex-1], lessonIndex: widget.lessonIndex))).then(onGoBack);
          // Navigate to Conversation
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationUI(transcript: transcript1, path: '', lessonIndex: widget.lessonIndex))).then(onGoBack);
          // Navigate to M.C.
          // Navigator.push(context, MaterialPageRoute(builder: (context) => MultipleChoiceUI(questions: quiz1)));
          // Navigate to Neuroscience Paragraphs.
          // Navigator.push(context, MaterialPageRoute(builder: (context) => NeuroscienceUI(pageText: exerciseTip)));
        });
  }
  FutureOr onGoBack(dynamic val) {
    setState(() {});
}
}
