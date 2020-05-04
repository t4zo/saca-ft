import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Speak extends StatefulWidget {
  @override
  _SpeakState createState() => _SpeakState();
}

class _SpeakState extends State<Speak> {

  FlutterTts flutterTts;

  void setLanguage(String lang) async {
    await flutterTts.setLanguage(lang);
  }

  @override
  void initState() {
    super.initState();
    setLanguage('pt-BR');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}