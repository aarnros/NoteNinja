import 'dart:collection';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class SettingsPage extends StatelessWidget {
  // HashMap<String, dynamic> currSettings = ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(children: [
        Text('Settings'),
        Row(
          children: [
            Text('Use 24 hour time'),
            Checkbox(value: true, onChanged: (value) {}),
          ],
        )
      ]),
    );
  }
}
