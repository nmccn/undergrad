import 'package:flutter/material.dart';
import 'package:sif_book/globals/globals.dart';
import 'chapter.dart';

class ChapterMenu extends StatefulWidget {
  // List of the chapters and their associated parameters. (chapterIndex can be derived from the index of our loop (+1))
  static const List<String> titles = ['Chapter 1:', 'Chapter 2:', 'Chapter 3:', 'Chapter 4:', 'Chapter 5:', 'Chapter 6:', 'Chapter 7:'];
  static const List<String> subtitles = ['Introducing Ourselves', 'Indefinite Articles', 'Family Vocabulary', 'Working With Numbers', 'Learn About the Spanish Speaking World', 'Practice -AR Verbs', 'The Verb Ir'];
  static const List<String> iconPaths = ['assets/icons/c1.png', 'assets/icons/c2.png', 'assets/icons/c3.png', 'assets/icons/c4.png', 'assets/icons/c5.png', 'assets/icons/c6.png','assets/icons/c7.png'];
  static const List<int> numberOfLessons = [5, 1, 1, 1, 1, 1, 1];
  static var lessonInfo = [[null, null], [null, null, null], [null, null, null, null], [null, null, null, null, null], [null], [null], [null]];
  /*
    We need to figure out a way to maintain the # of lessons, lesson data, etc. It's kind of convoluted.
   */
  const ChapterMenu({Key? key}) : super(key: key);

  @override
  _ChapterMenuState createState() => _ChapterMenuState();
}

class _ChapterMenuState extends State<ChapterMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          appBar: AppBar(title: const Text('Table of Contents')),
          body: ListView(
            children: <Widget>[
              for (int i = 0; i < ChapterMenu.titles.length; i++)
                ChapterButton(
                    title: ChapterMenu.titles[i],
                    subtitle: ChapterMenu.subtitles[i],
                    iconPath: ChapterMenu.iconPaths[i],
                    numberOfLessons: ChapterMenu.numberOfLessons[i],
                    lessonInfo: ChapterMenu.lessonInfo[i],
                    chapterIndex: i+1
                )
            ],
          )
        ),
      ),
    );
  }
}

