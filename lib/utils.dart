import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:icalendar_parser/icalendar_parser.dart';

class Event {
  final String title;
  final String description;
  final Duration duration;
  final DateTime start;
  final DateTime end;
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

  String get formattedDuration {
    String startHour = start.hour.toString();
    String startMinute = start.minute.toString();
    String endHour = end.hour.toString();
    String endMinute = end.minute.toString();
    return '$startHour:$startMinute - $endHour:$endMinute';
  }

  String toICSEvent() {
    String formattedStart = start.toUtc().toIso8601String();
    String formattedEnd = end.toUtc().toIso8601String();
    String icsString = 'BEGIN:VEVENT\n'
        'SUMMARY:$title\n'
        'DTSTART:$formattedStart\n'
        'DTEND:$formattedEnd\n'
        'DESCRIPTION:$description\n'
        'END:VEVENT\n';
    // print(icsString);
    return icsString;
  }
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

void getICS() {
  for (var event in kEvents.values) {
    for (var item in event) {
      print(item.toICSEvent());
    }
  }
}
