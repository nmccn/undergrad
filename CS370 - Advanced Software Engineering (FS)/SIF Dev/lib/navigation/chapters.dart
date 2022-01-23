import 'dart:async';
import 'package:flutter/material.dart';
import 'LessonMenu/ch1lessons.dart';
import 'LessonMenu/ch2lessons.dart';
import 'LessonMenu/ch3lessons.dart';
import 'LessonMenu/ch4lessons.dart';
import 'LessonMenu/ch5lessons.dart';
import '../globals/globals.dart';

class Chapters extends StatefulWidget {
  const Chapters({Key? key}) : super(key: key);

  @override
  State<Chapters> createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  @override
  // The widget being built here is the entire screen, and the body: ListWidget() creates an inner widget that is the list of Chapters (ToC).
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(title: const Text('Table of Contents')),
          body: const ListWidget(),
        ),
      ),
    );
  }
}

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
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/c1.png')),
            title: const Text('Chapter 1:'),
            subtitle: const Text('Introducing Ourselves'),
            trailing: (chapterComplete >= 1) ? unlocked : locked,
            selected: (chapterComplete >= 1) ? true : false,
            enabled: (chapterComplete >= 1) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Chapter1Lessons()))
                  .then(onGoBack);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/c2.png')),
            title: const Text('Chapter 2:'),
            subtitle: const Text('Indefinite Articles'),
            trailing: (chapterComplete >= 2) ? unlocked : locked,
            selected: (chapterComplete >= 2) ? true : false,
            enabled: (chapterComplete >= 2) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Chapter2Lessons()))
                  .then(onGoBack);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/c3.png')),
            title: const Text('Chapter 3:'),
            subtitle: const Text('Family Vocabulary'),
            trailing: (chapterComplete >= 3) ? unlocked : locked,
            selected: (chapterComplete >= 3) ? true : false,
            enabled: (chapterComplete >= 3) ? true : false,
            onTap: () {
              // TODO
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Chapter1Lessons()))
                  .then(onGoBack);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/c4.png')),
            title: const Text('Chapter 4:'),
            subtitle: const Text('Working With Numbers'),
            trailing: (chapterComplete >= 4) ? unlocked : locked,
            selected: (chapterComplete >= 4) ? true : false,
            enabled: (chapterComplete >= 4) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Chapter4Lessons()))
                  .then(onGoBack);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/c5.png')),
            title: const Text('Chapter 5:'),
            subtitle: const Text('Learn About the Spanish Speaking World'),
            trailing: (chapterComplete >= 5) ? unlocked : locked,
            selected: (chapterComplete >= 5) ? true : false,
            enabled: (chapterComplete >= 5) ? true : false,
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Chapter5Lessons()))
                  .then(onGoBack);
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
