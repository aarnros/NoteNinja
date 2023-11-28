import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:note_ninja/utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:intl/intl.dart';

Future<void> addEventDialog(
    BuildContext context,
    StateSetter setState,
    DateTime selectedDay,
    LinkedHashMap<DateTime, List<Event>> kEvents,
    ValueNotifier<List<Event>> selectedEvents) {
  String eventTitle = "";
  String eventDescription = "";
  DateTime selectedDate =
      DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.fromDateTime(DateTime(
          selectedDate.year, selectedDate.day, startTime.hour, startTime.minute)
      .add(Duration(hours: 1)));

  bool use24HourClock = Provider.of<GlobalAppState>(context, listen: true).use24HourTime;
      

  TextEditingController startDateController = TextEditingController();
  // TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  startDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  // endDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  startTimeController.text = formatTime(startTime, use24HourClock: use24HourClock);
  endTimeController.text = formatTime(endTime, use24HourClock: use24HourClock);

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
        startTimeController.text = formatTime(startTime, use24HourClock: use24HourClock);
      });
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1))),
    );
    if (picked != null &&
        picked != endTime &&
        timeToDouble(endTime) > timeToDouble(startTime)) {
      setState(() {
        endTime = picked;
        endTimeController.text = formatTime(endTime, use24HourClock: use24HourClock);
      });
    }
  }

  return showAdaptiveDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )),
        // title: const Text('Add Event'),
        child: Container(
          height: 300,
          width: 300,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Event Name',
                ),
                onChanged: (value) {
                  eventTitle = value;
                },
              ),
              TextField(
                // expands: true,
                // maxLines: null,
                // minLines: null,
                decoration: const InputDecoration(
                  hintText: 'Event Description',
                ),
                onChanged: (value) {
                  eventDescription = value;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: Center(
                          child: TextField(
                    controller: startDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Event Date',
                    ),
                  ))),
                  IconButton(
                    onPressed: () => selectDate(context),
                    icon: Icon(Icons.calendar_today),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Center(
                    child: TextField(
                      controller: startTimeController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Event Time',
                      ),
                    ),
                  )),
                  IconButton(
                    onPressed: () => selectStartTime(context),
                    icon: Icon(Icons.access_time),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Center(
                    child: TextField(
                      controller: endTimeController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Event End Time',
                      ),
                    ),
                  )),
                  IconButton(
                    onPressed: () => selectEndTime(context),
                    icon: Icon(Icons.access_time),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  DateTime start = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      startTime.hour,
                      startTime.minute);
                  DateTime end = DateTime(selectedDate.year, selectedDate.month,
                      selectedDate.day, endTime.hour, endTime.minute);
                  Event newEvent = Event(eventTitle, eventDescription, start,
                      end.difference(start));
                  setState(
                    () {
                      if (kEvents.containsKey(selectedDate)) {
                        kEvents[selectedDate]?.add(newEvent);
                      } else {
                        final newEventList = List<Event>.empty(growable: true);
                        newEventList.add(newEvent);
                        kEvents.addAll(<DateTime, List<Event>>{
                          selectedDate: newEventList
                        });
                      }
                      kEvents[selectedDate]!
                          .sort((a, b) => a.start.compareTo(b.start));
                      selectedEvents.value = kEvents[selectedDate]!.toList();
                    },
                  );
                  // createEvent(selectedDate, title, description, )
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
