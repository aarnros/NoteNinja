import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/new_event_dialog.dart';
import '../utils.dart';
import '../main.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  //Limits
  final kFirstDay = DateTime.utc(2021, 1, 1);
  final kLastDay = DateTime.utc(2030, 12, 31);

  //Formating
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  //events
  late final ValueNotifier<List<Event>> _selectedEvents;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      bool use24HourClock = Provider.of<GlobalAppState>(context, listen: true).use24HourTime;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Calendar'),
        actions: [
          IconButton(onPressed: shareICS, icon: Icon(Icons.download)),
          IconButton(onPressed: importICS, icon: Icon(Icons.upload))
        ],
      ),
      //"+" button on calendar page, will eventually be used to add events
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEventDialog(
              context, setState, _selectedDay!, kEvents, _selectedEvents);
        },
        tooltip: 'Add Event',
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar(
            eventLoader: _getEventsForDay,
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
              _selectedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print(value[index].toICSEvent()),
                        title: Text('${value[index]}'),
                        subtitle: Text(value[index].description),
                        leading: Text(
                          value[index]
                              .startToEndString(use24HourClock: use24HourClock),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              kEvents[_selectedDay!]!.removeAt(index);
                              _selectedEvents.value =
                                  kEvents[_selectedDay!]!.toList();
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
