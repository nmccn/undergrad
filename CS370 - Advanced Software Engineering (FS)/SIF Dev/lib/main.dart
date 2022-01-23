import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splashscreen.dart';
import 'globals/globals.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  // Force the program to wait
  WidgetsFlutterBinding.ensureInitialized();

  // Demo json
  String ch1DemoFlashcard =
      await rootBundle.loadString('assets/json/Chapter_1/Flashcards/demo.json');
  ch1DemoFlashcardResponse = json.decode(ch1DemoFlashcard);

  // CHAPTER 1 JSON
  String ch1flashcard1 = await rootBundle
      .loadString('assets/json/Chapter_1/Flashcards/alphabet.json');
  String ch1flashcard2 = await rootBundle
      .loadString('assets/json/Chapter_1/Flashcards/chapter_vocab.json');
  String ch1flashcard3 = await rootBundle
      .loadString('assets/json/Chapter_1/Flashcards/ser_conjugation.json');
  String ch1mc1 = await rootBundle.loadString(
      'assets/json/Chapter_1/Multiple_Choice/descriptive_adjectives.json');
  String ch1Mc2 = await rootBundle.loadString(
      'assets/json/Chapter_1/Multiple_Choice/plural_definite_articles.json');
  String ch1Mc3 = await rootBundle
      .loadString('assets/json/Chapter_1/Multiple_Choice/ser_conjugation.json');
  String ch1Mc4 = await rootBundle.loadString(
      'assets/json/Chapter_1/Multiple_Choice/singular_definite_articles.json');
  String ch1Transcript = await rootBundle.loadString(
      'assets/json/Chapter_1/Transcripts/tamera_clara_conversation.json');

  // Chapter 2 json
  String ch2Mc1 = await rootBundle.loadString(
      'assets/json/Chapter_2/Multiple_Choice/articulous_indefinidos.json');
  String ch2flashcard1 = await rootBundle
      .loadString('assets/json/Chapter_2/Flashcards/preposiciones.json');
  String ch2transcript = await rootBundle.loadString(
      'assets/json/Chapter_2/Transcripts/unidad_2_conversation.json');

  // TODO Chapter 3 json upload

  // Chapter 4 json upload
  String chap4Flashcard1 = await rootBundle.loadString(
      'assets/json/Chapter_4/Flashcards/1_one_to_ten_flashcards.json');
  String chap4Flashcard2 = await rootBundle.loadString(
      'assets/json/Chapter_4/Flashcards/2_eleven_to_twenty-nine_flashcards.json');
  String chap4Flashcard3 = await rootBundle
      .loadString('assets/json/Chapter_4/Flashcards/e_days_flascards.json');
  String chap4Flashcard4 = await rootBundle.loadString(
      'assets/json/Chapter_4/Flashcards/e_expressions_of_time_flashcards.json');
  String chap4Flashcard5 = await rootBundle
      .loadString('assets/json/Chapter_4/Flashcards/e_months_flashcards.json');
  String chap4MC1 = await rootBundle.loadString(
      'assets/json/Chapter_4/Multiple_Choice/3_bigger_numbers_quiz.json');
  String chap4MC2 = await rootBundle.loadString(
      'assets/json/Chapter_4/Multiple_Choice/4_ser_la_hora_quiz.json');
  String chap4Transcript = await rootBundle.loadString(
      'assets/json/Chapter_4/Transcripts/marcos_ana_conversation.json');

  // Chapter 5 json upload
  String chap5Flashcard1 = await rootBundle
      .loadString('assets/json/Chapter_5/Flashcards/vacation_vocab.json');
  String chap5MC1 = await rootBundle
      .loadString('assets/json/Chapter_5/Multiple_Choice/nationalities.json');

  // Decoding the json files
  ch1FlashCardResponse1 = json.decode(ch1flashcard1);
  ch1FlashCardResponse2 = json.decode(ch1flashcard2);
  ch1FlashCardResponse3 = json.decode(ch1flashcard3);
  ch1MultipleChoice1 = json.decode(ch1mc1);
  ch1MultipleChoice2 = json.decode(ch1Mc2);
  ch1MultipleChoice3 = json.decode(ch1Mc3);
  ch1MultipleChoice4 = json.decode(ch1Mc4);
  ch1AudioTranscript = json.decode(ch1Transcript);
  // Chapter 2
  ch2MultipleChoice1 = json.decode(ch2Mc1);
  ch2Flashcard1 = json.decode(ch2flashcard1);
  ch2Transcript1 = json.decode(ch2transcript);

  // TODO Chapter 3
  ch4FlashCardResponse1 = json.decode(chap4Flashcard1);
  ch4FlashCardResponse2 = json.decode(chap4Flashcard2);
  ch4FlashCardResponse3 = json.decode(chap4Flashcard3);
  ch4FlashCardResponse4 = json.decode(chap4Flashcard4);
  ch4FlashCardResponse5 = json.decode(chap4Flashcard5);
  ch4MCResponse1 = json.decode(chap4MC1);
  ch4MCResponse2 = json.decode(chap4MC2);

  ch4TranscriptResponse1 = json.decode(chap4Transcript);
  ch5FlashCardResponse1 = json.decode(chap5Flashcard1);
  ch5MCResponse1 = json.decode(chap5MC1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIF Language School',
      theme: ThemeData(
        primarySwatch: sifBlue,
      ),
      home: const SplashScreen(),
    );
  }
}
