import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:english_words/english_words.dart';
import 'package:note_ninja/theme_const/theme_const.dart';
import 'package:provider/provider.dart';
import 'pages/sign_up_page.dart';
import 'pages/home_page.dart';

Future<void> main() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SignUpApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: defaultTheme,
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
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
