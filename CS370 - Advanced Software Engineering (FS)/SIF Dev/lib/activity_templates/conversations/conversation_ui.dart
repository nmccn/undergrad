import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../globals/globals.dart';
import 'conversation_logic.dart';

class ConversationUI extends StatefulWidget {
  // Path to the audio and JSON file containing a transcript of whatever is being spoken.
  final String path;
  final int lessonIndex;
  final dynamic transcript;

  const ConversationUI(
      {Key? key,
      required this.path,
      required this.transcript,
      required this.lessonIndex})
      : super(key: key);

  @override
  _ConversationUIState createState() => _ConversationUIState();
}

class _ConversationUIState extends State<ConversationUI> {
  late final ConversationLogic _conversationLogic;

  @override
  void initState() {
    super.initState();
    _conversationLogic = ConversationLogic(widget.path, widget.lessonIndex);
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: "Exercise",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: sifOrange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _showToast,
          label: const Text('Neuroscience Tip'),
          backgroundColor: sifBlue),
      appBar: AppBar(title: const Text('Native Conversation')),
      body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 30),
                alignment: Alignment.bottomCenter,
                child: Image.asset("assets/images/exerciseBrain.png")),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(widget.transcript['transcript'],
                      style: const TextStyle(fontSize: 24))),
            ),
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: _conversationLogic.progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                  progress: value.current,
                  total: value.total,
                  onSeek: _conversationLogic.seek,
                );
              },
            ),
            ValueListenableBuilder<ButtonState>(
                valueListenable: _conversationLogic.buttonNotifier,
                builder: (_, value, __) {
                  switch (value) {
                    case ButtonState.paused:
                      return IconButton(
                        icon: const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: _conversationLogic.play,
                      );
                    case ButtonState.playing:
                      return IconButton(
                        icon: const Icon(Icons.pause),
                        iconSize: 32.0,
                        onPressed: _conversationLogic.pause,
                      );
                  }
                })
          ])),
    );
  }
}
