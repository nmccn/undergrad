import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sif_book/globals/globals.dart';
import 'lesson_menu.dart';

class ChapterButton extends StatefulWidget {
  // Variables that we will pass in when constructing each button.
  final dynamic lessonInfo;
  final int numberOfLessons;
  final int chapterIndex;
  final String iconPath;
  final String title;
  final String subtitle;
  const ChapterButton({Key? key, required this.title, required this.subtitle, required this.iconPath, required this.chapterIndex, required this.numberOfLessons, required this.lessonInfo}) : super(key: key);

  @override
  _ChapterButtonState createState() => _ChapterButtonState();
}

class _ChapterButtonState extends State<ChapterButton> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(widget.iconPath)),
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      trailing: (chapterComplete >= widget.chapterIndex) ? unlocked  : locked,
      selected: (chapterComplete >= widget.chapterIndex) ? true : false,
      enabled: (chapterComplete >= widget.chapterIndex) ? true : false,
      onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LessonMenu(numberOfLessons: widget.numberOfLessons, lessonJSON: widget.lessonInfo))).then(onGoBack);
    });
  }
  FutureOr onGoBack(dynamic val) {
    setState(() {});
  }
}