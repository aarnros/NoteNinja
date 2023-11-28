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
      body: Center(
        child: SettingsList(sections: [
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
            // SettingsTile(
            //   title: Text('Default Calendar View'),
            //   leading: Icon(Icons.calendar_today),
            //   onPressed: (BuildContext context) {
            //     return showAdaptiveDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             title: Text('Default Calendar View'),
            //             content: SizedBox(
            //               width: 300,
            //               height: 100,
            //               child: Column(
            //                 children: [
            //                   Text('Select the default calendar view'),
            //                   DropdownButton(
            //                     isExpanded: true,
            //                     items: [
            //                       DropdownMenuItem(
            //                         child: Text('Month'),
            //                         value: 'month',
            //                       ),
            //                       DropdownMenuItem(
            //                         child: Text('Week'),
            //                         value: 'week',
            //                       ),
            //                       DropdownMenuItem(
            //                         child: Text('Day'),
            //                         value: 'day',
            //                       ),
            //                     ],
            //                     onChanged: (value) {},
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             actions: [
            //               // DropdownButton(
            //               //   items: [
            //               //     DropdownMenuItem(
            //               //       child: Text('Month'),
            //               //       value: 'month',
            //               //     ),
            //               //     DropdownMenuItem(
            //               //       child: Text('Week'),
            //               //       value: 'week',
            //               //     ),
            //               //     DropdownMenuItem(
            //               //       child: Text('Day'),
            //               //       value: 'day',
            //               //     ),
            //               //   ],
            //               //   onChanged: (value) {},
            //               // ),
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //                 child: Text('Cancel'),
            //               ),
            //               TextButton(
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //                 child: Text('OK'),
            //               ),
            //             ],
            //           );
            //         });
            //   },
            // )
            // SettingsTile.switchTile(
            //   initialValue: darkMode,
            //   title: Text('Dark Mode'),
            //   leading: Icon(Icons.dark_mode),
            //   onToggle: (bool value) {
            //     Provider.of<GlobalAppState>(context, listen: false).darkMode =
            //         value;
            //     GlobalApp.of(context)!.changeTheme(value);
            //   },
            // ),
          ]),
        ]),
      ),
    );
  }
}
