import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/event_provider.dart';
import 'package:proyecto/widgets/event_list_items.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, provider, child) {
        return EventListItems(events: provider.events);
      },
    );
  }
}
