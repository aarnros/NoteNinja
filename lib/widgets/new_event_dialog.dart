import 'package:flutter/material.dart';
import 'package:note_ninja/utils.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:intl/intl.dart';

Future<void> addEventDialog(BuildContext context, StateSetter setState) {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));

  bool use24HourClock = Provider.of<GlobalAppState>(context, listen: false)
          .userSettings['use24HourClock'] ??
      false;

  String formatTime(TimeOfDay time) {
    if (use24HourClock) {
      return '${time.hour}:${time.minute}';
    } else {
      DateTime dt = DateTime(0, 0, 0, time.hour, time.minute);
      DateFormat("h:mma").format(dt);
      return '${dt.hour}:${dt.minute}';
    }
  }

  TextEditingController startDateController = TextEditingController();
  // TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  startDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  // endDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  startTimeController.text = formatTime(startTime);
  endTimeController.text = formatTime(endTime);

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
        startTimeController.text = formatTime(startTime);
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
        endTimeController.text = formatTime(endTime);
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
              ),
              TextField(
                // expands: true,
                // maxLines: null,
                // minLines: null,
                decoration: const InputDecoration(
                  hintText: 'Event Description',
                ),
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
