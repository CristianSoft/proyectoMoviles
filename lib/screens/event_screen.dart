import 'package:flutter/material.dart';
import 'package:proyecto/widgets/event_list.dart';
import 'package:proyecto/providers/event_provider.dart';
import 'package:provider/provider.dart';

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
      body: Column(
        children: <Widget>[
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('lib/images/LogoPolimatchSmall.png'),
              ),
              const Padding(
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
          const SizedBox(
            height: 20,
          ),
          const Row(
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
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: Provider.of<EventProvider>(context, listen: false)
                .checkEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const EventList();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
