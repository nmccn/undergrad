import 'package:flutter/material.dart';

// Flags for Chapters/Lessons completed
int chapterComplete = 1;
int lessonsComplete = 0;

// JSON DATA
// Chapter 1 JSON data
late dynamic ch1DemoFlashcardResponse;
late dynamic ch1FlashCardResponse1;
late dynamic ch1FlashCardResponse2;
late dynamic ch1FlashCardResponse3;
late dynamic ch1MultipleChoice1;
late dynamic ch1MultipleChoice2;
late dynamic ch1MultipleChoice3;
late dynamic ch1MultipleChoice4;
late dynamic ch1AudioTranscript;

// Chapter 2 JSON data
late dynamic ch2MultipleChoice1;
late dynamic ch2Flashcard1;
late dynamic ch2Transcript1;

// Chapter 3 JSON data

// Chapter 4 JSON data
late dynamic ch4FlashCardResponse1;
late dynamic ch4FlashCardResponse2;
late dynamic ch4FlashCardResponse3;
late dynamic ch4FlashCardResponse4;
late dynamic ch4FlashCardResponse5;
late dynamic ch4MCResponse1;
late dynamic ch4MCResponse2;
late dynamic ch4TranscriptResponse1;

// Chapter 5 JSON data
late dynamic ch5FlashCardResponse1;
late dynamic ch5MCResponse1;

// Other JSON data
late dynamic flashCardResponse;
late dynamic flashCardResponse2;

// Icons for locked/unlocked items on navigation menu
const Icon locked = Icon(Icons.lock);
const Icon unlocked = Icon(Icons.lock_open_sharp);

// SIF Language School 3 colors & corresponding gradient/swatch
const Map<int, Color> blueSwatch = {
  50: Color.fromRGBO(11, 83, 148, .1),
  100: Color.fromRGBO(11, 83, 148, .2),
  200: Color.fromRGBO(11, 83, 148, .3),
  300: Color.fromRGBO(11, 83, 148, .4),
  400: Color.fromRGBO(11, 83, 148, .5),
  500: Color.fromRGBO(11, 83, 148, .6),
  600: Color.fromRGBO(11, 83, 148, .7),
  700: Color.fromRGBO(11, 83, 148, .8),
  800: Color.fromRGBO(11, 83, 148, .9),
  900: Color.fromRGBO(11, 83, 148, 1),
};

const Map<int, Color> greenSwatch = {
  50: Color.fromRGBO(56, 118, 29, .1),
  100: Color.fromRGBO(56, 118, 29, .2),
  200: Color.fromRGBO(56, 118, 29, .3),
  300: Color.fromRGBO(56, 118, 29, .4),
  400: Color.fromRGBO(56, 118, 29, .5),
  500: Color.fromRGBO(56, 118, 29, .6),
  600: Color.fromRGBO(56, 118, 29, .7),
  700: Color.fromRGBO(56, 118, 29, .8),
  800: Color.fromRGBO(56, 118, 29, .9),
  900: Color.fromRGBO(56, 118, 29, 1),
};

const Map<int, Color> orangeSwatch = {
  50: Color.fromRGBO(244, 115, 33, .1),
  100: Color.fromRGBO(244, 115, 33, .2),
  200: Color.fromRGBO(244, 115, 33, .3),
  300: Color.fromRGBO(244, 115, 33, .4),
  400: Color.fromRGBO(244, 115, 33, .5),
  500: Color.fromRGBO(244, 115, 33, .6),
  600: Color.fromRGBO(244, 115, 33, .7),
  700: Color.fromRGBO(244, 115, 33, .8),
  800: Color.fromRGBO(244, 115, 33, .9),
  900: Color.fromRGBO(244, 115, 33, 1),
};

// MaterialColor is the object used to color stuff inside the app, and these objects require a "gradient" which is the Swatch.
const MaterialColor sifBlue = MaterialColor(0xFF0b5394, blueSwatch);
const MaterialColor sifGreen = MaterialColor(0xFF38761d, greenSwatch);
const MaterialColor sifOrange = MaterialColor(0xFFf47321, orangeSwatch);
