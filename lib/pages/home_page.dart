import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/pages/generator_page.dart';
import '/pages/fav_page.dart';
import '/pages/new_note_page.dart';
import '/pages/saved_notes_page.dart';
import '/pages/calendar_page.dart';
import '/pages/settings_page.dart';

class MyHomePage extends StatefulWidget {
  UserCredential? userCredential;
  MyHomePage([this.userCredential]);
  @override
  State<MyHomePage> createState() => _MyHomePageState(this.userCredential);
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  UserCredential? userCredential;
  _MyHomePageState(this.userCredential);
  @override
  Widget build(BuildContext context) {
    Widget page;
    //Do we need brakes for each case?
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = FavoritesPage();
      case 2:
        page = SavedNotesPage();
      case 3:
        page = CalendarPage();
      case 4:
        page = SettingsPage();

      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    String homePageText = "Note Ninja";
    String homePageLeadingText = "Welcome, ";
    if (userCredential != null) {
      homePageLeadingText = "Welcome, ${userCredential!.user!.displayName}";
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Text(homePageText),
            Spacer(),
            Text(homePageLeadingText),
          ],
        )),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorite Notes'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.notes),
                    label: Text('View Notes'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.calendar_month),
                    label: Text('View Calendar'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
