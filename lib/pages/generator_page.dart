import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import '../utils.dart';

class GeneratorPage extends StatefulWidget {
  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  late final ValueNotifier<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = ValueNotifier(getFutureEvents());
  }

  List<Event> getFutureEvents() {
    var futureEvents =
        kEvents.entries.where((entry) => entry.key.isAfter(DateTime.now()));
    List<Event> futureEventsList = [];
    for (var event in futureEvents) {
      futureEventsList.addAll(event.value);
    }
    return futureEventsList;
  }

  @override
  Widget build(BuildContext context) {
    bool use24HourClock =
        Provider.of<GlobalAppState>(context, listen: true).use24HourTime;
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Upcoming Events Tab
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: futureEvents,
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.all(10),
                          child: Card(
                            child: ListTile(
                              title: Text(value[index].title),
                              subtitle: Text(value[index].description),
                              trailing: Text(
                                value[index].dateString +
                                    ' ' +
                                    value[index].startToEndString(
                                        use24HourClock: use24HourClock),
                                // trailing: IconButton(
                                //   icon: Icon(Icons.delete),
                                //   onPressed: () {
                                //     setState(() {
                                //       DateTime? date = value[index].start;

                                //       kEvents[date]!.removeAt(index);
                                //     });
                                //   },
                                // ),
                              ),
                            ),
                          ));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
