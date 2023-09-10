import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/event_provider.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final eventsData =
        Provider.of<EventProvider>(context, listen: false).events;

    return SizedBox(
      height: 10000,
      child: ListView.builder(
          itemCount: eventsData.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color(0xFFF91659), width: 2.0),
              ),
              elevation: 5,
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      child: Image(
                        image:
                            NetworkImage(eventsData[index].imageUrl, scale: 3),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 6),
                          child: Text(
                            eventsData[index].eventName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 6, right: 8),
                          child: Text(
                            eventsData[index].description,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                eventsData[index].date,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Icon(
                                Icons.calendar_month,
                                color: Color(0xFFF91659),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
