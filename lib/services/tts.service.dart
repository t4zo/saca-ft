import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  FlutterTts _flutterTts;

  TtsService() {
    this._flutterTts = new FlutterTts();
    configureTts();
  }

  FlutterTts get flutterTts => _flutterTts;

  void configureTts() async {
    await _flutterTts.setLanguage('pt-BR');
    await _flutterTts.setVoice('pt-br-x-afs-local');
    await _flutterTts.setSharedInstance(true);
    await _flutterTts.setSpeechRate(1.0);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future speak(String text) async {
    await _flutterTts.speak(text);
  }
}
