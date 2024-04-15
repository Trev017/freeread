import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  String? audioBookTitle;
  String? audioBookAuthor;
  String? audioBookChapter;
  int? audioBookDuration;
  bool? playerStatus;

  AudioProvider({
    this.audioBookTitle,
    this.audioBookAuthor,
    this.audioBookChapter,
    this.audioBookDuration,
    this.playerStatus = false,
  }
  );

  void setAudioBookTitle(String s) async {
    audioBookTitle = s;
    notifyListeners();
  }

  void setAudioBookAuthor(String s) async {
    audioBookAuthor = s;
    notifyListeners();
  }

  void setAudioBookChapter(String s) async {
    audioBookChapter = s;
    notifyListeners();
  }

  void setAudioBookDuration(int d) async {
    audioBookDuration = d;
    notifyListeners();
  }
}