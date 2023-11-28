import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'main.dart';
import 'package:provider/provider.dart';
import 'io.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:intl/intl.dart';
import 'dart:html'
    as webFile; //https://stackoverflow.com/questions/57182634/how-can-i-read-and-write-files-in-flutter-web
import 'package:file_picker/file_picker.dart';

const String kICSFileName = 'example.ics';

class Event {
  final String title;
  final String description;
  final Duration duration;
  final DateTime start;
  final DateTime end;
  final String userEmail = 'test@example.com';
  final DateTime dateStamp = DateTime.now();

  Event(this.title, this.description, this.start, this.duration)
      : end = start.add(duration);

  Event.fromEnd(this.title, this.description, this.start, this.end)
      : duration = end.difference(start);
  // Event(this.title, this.description, this.start, this.end);

  @override
  String toString() => title;

  bool isWithin(DateTime start, DateTime end) {
    return this.start.isAfter(start) && this.end.isBefore(end);
  }

  String get durationString {
    String hours = duration.inHours.toString();
    String minutes = (duration.inMinutes % 60).toString();
    return '$hours:$minutes';
  }

  String startToEndString({bool use24HourClock = false}) {
    DateFormat format = use24HourClock ? DateFormat.Hm() : DateFormat.jm();
    return '${format.format(start)} - ${format.format(end)}';
  }

  String toICSEvent() {
    DateFormat icsFormat = DateFormat('yyyyMMdd\'T\'HHmmss\'Z\'');
    String icsString = 'BEGIN:VEVENT\n'
        'UID:$userEmail\n'
        'DTSTAMP:${icsFormat.format(dateStamp.toUtc())}\n'
        'SUMMARY:$title\n'
        'DTSTART:${icsFormat.format(start.toUtc())}\n'
        'DTEND:${icsFormat.format(end.toUtc())}\n'
        'DESCRIPTION:$description\n'
        'END:VEVENT\n';
    // print(icsString);
    return icsString;
  }
}

String formatTime(TimeOfDay time, {bool use24HourClock = false}) {
  DateTime dt = DateTime(0, 0, 0, time.hour, time.minute);
  DateFormat format = use24HourClock ? DateFormat.Hm() : DateFormat.jm();
  return format.format(dt);
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

//example events
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

const Duration _kEventDuration = Duration(hours: 1);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1,
        (index) => Event(
            'Event $item | ${index + 1}',
            'Test Desc',
            DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
            _kEventDuration))
}..addAll({
    kToday: [
      Event('Today\'s Event 1', 'Test Desc', kToday, _kEventDuration),
      Event('Today\'s Event 2', 'Test Desc', kToday, _kEventDuration),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

void createEvent(
    DateTime date, String title, String description, Duration duration) {
  kEvents.update(
      date, (value) => value..add(Event(title, description, date, duration)),
      ifAbsent: () => [Event(title, description, date, duration)]);
}

double timeToDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

String getICSString() {
  String icsString = 'BEGIN:VCALENDAR\n'
      'VERSION:2.0\n'
      'PRODID:-//Flutter//Event Calendar//EN\n';

  for (var event in kEvents.values) {
    for (var item in event) {
      icsString += item.toICSEvent();
      break;
      // print(item.toICSEvent());
    }
    break;
  }
  icsString += 'END:VCALENDAR';
  return icsString;
}

void shareICS() {
  String icsString = getICSString();
  if (kIsWeb) {
    Uint8List bytes = Uint8List.fromList(utf8.encode(icsString));
    var blob = webFile.Blob([bytes], 'text/calendar', 'native');
    webFile.AnchorElement(
        href: webFile.Url.createObjectUrlFromBlob(blob).toString())
      ..setAttribute("download", kICSFileName)
      ..click();
  } else {
    writeString(kICSFileName, icsString);
  }
  // final bytes = File('example.ics').writeAsStringSync(icsString);
}

void importICS() async {
  String icsString = '';
  if (kIsWeb) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ics'],
    );
    if (result != null) {
      try {
        PlatformFile platformFile = result.files.first;
        webFile.File file =
            webFile.File(platformFile.bytes!, platformFile.name);

        final reader = webFile.FileReader();
        reader.readAsText(file);
        reader.onLoadEnd.listen((event) {
          icsString = reader.result.toString();
        });
      } catch (e) {
        print("Error: " + e.toString());
      }
    } else {
      // User canceled the picker
    }
    print(icsString);

    // if (icsString != '') {
    //   ICalendar calendar = ICalendar.fromString(icsString);
    //   Map<String, dynamic> calDict = calendar.toJson();
    //   for (var item in calDict['events']) {
    //     String title = item['summary'];
    //     String description = item['description'];
    //     DateTime start = DateTime.parse(item['start']);
    //     DateTime end = DateTime.parse(item['end']);
    //     createEvent(start, title, description, end.difference(start));
    //   }
    // }
  }
}
