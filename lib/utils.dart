import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  // final String description;
  // final DateTime start;
  // final DateTime end;
  const Event(this.title);
  // Event(this.title, this.description, this.start, this.end);

  @override
  String toString() => title;
}


final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);


//example events
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);



final _kEventSource = 
{ for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')) }
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
