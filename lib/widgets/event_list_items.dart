import 'package:flutter/material.dart';
import 'package:proyecto/dtos/event_model.dart';

class EventListItems extends StatefulWidget {
  final List<Event> events;
  const EventListItems({super.key, required this.events});

  @override
  State<EventListItems> createState() => _EventListItemsState();
}

class _EventListItemsState extends State<EventListItems> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 10000,
          child: ListView.builder(
              itemCount: widget.events.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side:
                        const BorderSide(color: Color(0xFFF91659), width: 2.0),
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
                            image: NetworkImage(widget.events[index].imageUrl,
                                scale: 3),
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
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 6),
                              child: Text(
                                widget.events[index].eventName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: 6, right: 8),
                              child: Text(
                                widget.events[index].description,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.events[index].date,
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