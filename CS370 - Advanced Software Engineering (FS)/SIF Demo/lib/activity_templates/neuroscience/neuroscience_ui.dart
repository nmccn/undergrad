import 'package:flutter/material.dart';
import 'package:sif_book/globals/globals.dart';

class NeuroscienceUI extends StatelessWidget {
  final String pageText;
  const NeuroscienceUI({Key? key, required this.pageText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Increment the counter when the page is loaded.
    lessonsComplete += 1;
    return Scaffold(
        appBar: AppBar(title: const Text("Neuroscience Information")),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 200,
                  height: 200,
                  margin:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 30),
                  alignment: Alignment.bottomCenter,
                  child: Image.asset("assets/images/neuro_Flow.png")),
              Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child:
                          Text(pageText, style: const TextStyle(fontSize: 22))))
            ])));
  }
}
