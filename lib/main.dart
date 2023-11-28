import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:english_words/english_words.dart';
import 'package:note_ninja/theme_const/theme_const.dart';
import 'package:provider/provider.dart';
import 'pages/sign_up_page.dart';
import 'pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SignUpApp());
}

class GlobalApp extends StatelessWidget {
  UserCredential? userCredential;

  GlobalApp([this.userCredential]);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GlobalAppState(this.userCredential),
      child: MaterialApp(
        title: 'Note Ninja',
        theme: defaultTheme,
        home: MyHomePage(this.userCredential),
      ),
    );
  }
}

class GlobalAppState extends ChangeNotifier {
  UserCredential? userCredential;

  GlobalAppState([this.userCredential]);

  bool _use24HourTime = false;
  bool get use24HourTime => _use24HourTime;
  set use24HourTime(bool value) {
    _use24HourTime = value;
    notifyListeners();
  }

  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void addNote() {
    // TODO
  }
}
