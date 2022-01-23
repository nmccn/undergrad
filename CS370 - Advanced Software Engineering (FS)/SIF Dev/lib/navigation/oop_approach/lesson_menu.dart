import 'package:flutter/material.dart';
import 'lesson.dart';

class LessonMenu extends StatefulWidget {
  // # of lessons, and lessonJSON is a LIST of valid JSON files to pull into lessons.
  final int numberOfLessons;
  final dynamic lessonJSON;

  const LessonMenu({Key? key, required this.numberOfLessons, required this.lessonJSON}) : super(key: key);

  @override
  _LessonMenuState createState() => _LessonMenuState();
}

class _LessonMenuState extends State<LessonMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
            appBar: AppBar(title: const Text('Lesson Selection')),
            body: ListView(
              children: <Widget>[
                for (int i = 0; i < widget.numberOfLessons; i++)
                  LessonButton(
                      subtitle: 'Activity #${i+1}',
                      title: 'Lesson #${i+1}',
                      lessonInfo: widget.lessonJSON,
                      lessonIndex: i+1)
              ],
            )
        ),
      ),
    );
  }
}
