import 'dart:collection';
import 'package:note_ninja/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool use24HourClock =
        Provider.of<GlobalAppState>(context, listen: true).use24HourTime;
    bool darkMode = Provider.of<GlobalAppState>(context, listen: true).darkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(sections: [
        SettingsSection(title: Text('General'), tiles: [
          SettingsTile.switchTile(
            initialValue: use24HourClock,
            title: Text('Use 24-hour clock'),
            leading: Icon(Icons.access_time),
            onToggle: (bool value) {
              Provider.of<GlobalAppState>(context, listen: false)
                  .use24HourTime = value;
            },
          ),
          SettingsTile.switchTile(
            initialValue: darkMode,
            title: Text('Dark Mode'),
            leading: Icon(Icons.dark_mode),
            onToggle: (bool value) {
              Provider.of<GlobalAppState>(context, listen: false).darkMode =
                  value;
              GlobalApp.of(context)!.changeTheme(value);
            },
          ),
        ]),
      ]),
    );
  }
}
