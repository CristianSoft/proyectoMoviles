import 'package:flutter/material.dart';
import 'package:proyecto/widgets/event_list.dart';

class EventScreen extends StatefulWidget {
  static const routeName = '/event';
  EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.pets),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Próximos Eventos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFF91659),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: SizedBox(
                  height: 36,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.location_on_outlined,
                    size: 50,
                    color: Color(0xFFF91659),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          EventList()
        ],
      ),
    );
  }
}
