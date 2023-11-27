import 'dart:collection';
import '../utils.dart';

import 'package:flutter/material.dart';

Future<void> addEventDialog(BuildContext context, StateSetter setState,
    LinkedHashMap<DateTime, List<Event>> kEvents) {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String _name = "";
  String _description = "";
  TextEditingController startDateController = TextEditingController();
  // TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  // TextEditingController endTimeController = TextEditingController();
  startDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  // endDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  startTimeController.text = "${selectedTime.hour}:${selectedTime.minute}";

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

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        startTimeController.text =
            "${selectedTime.hour}:${selectedTime.minute}";
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
                onChanged: (text) => {_name = text},
              ),
              TextField(
                // expands: true,
                // maxLines: null,
                // minLines: null,
                decoration: const InputDecoration(
                  hintText: 'Event Description',
                ),
                onChanged: (value) => {_description = value},
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
                    onPressed: () => selectTime(context),
                    icon: Icon(Icons.access_time),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Event newEvent = Event(
                      _name,
                      _description,
                      DateTime(selectedDate.year, selectedDate.month,
                          selectedTime.hour, selectedTime.minute),
                      Duration());
                  print("new event");
                  print(newEvent.toString());
                  if (kEvents.containsKey(selectedDate)) {
                    kEvents[selectedDate]?.add(newEvent);
                    print("Contained the key, adding...");
                  } else {
                    final dateList = List<Event>.empty(growable: true);
                    print("Did not contain date...");
                    dateList.add(newEvent);
                    kEvents.addAll(
                        <DateTime, List<Event>>{selectedDate: dateList});
                    print(kEvents[selectedDate]);
                  }

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
