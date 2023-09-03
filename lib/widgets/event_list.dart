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

    final eventsDataProvider = Provider.of<EventProvider>(context, listen: false);

    eventsDataProvider.checkEvents();

    final eventsData = eventsDataProvider.events;

    return SizedBox(
      width: 300,
      height: 200,
      child: ListView.builder(
        itemCount: eventsData.length,
        itemBuilder: (context, index) {
        return SizedBox(
          height: 200,
          width: 150,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Color(0xFFF91659), width: 2.0),
            ),
            elevation: 5,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image(
                      image: NetworkImage(eventsData[index].imageUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      eventsData[index].eventName,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '3 Polimatches',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: Row(
                      children: [
                        Text(
                          eventsData[index].date,
                          style: const TextStyle(fontWeight: FontWeight.w400),
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
                  )
                ]),
          ),
        );
      }),
    );
  }
}
