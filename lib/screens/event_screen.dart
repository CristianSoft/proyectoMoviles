import 'package:flutter/material.dart';
import 'package:proyecto/screens/mapEvents_screen.dart';
import 'package:proyecto/widgets/event_list.dart';
import 'package:proyecto/providers/event_provider.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  static const routeName = '/event';
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isSearch = false;
  var textSearchController = TextEditingController();

  @override
  void initState() {
    textSearchController.addListener(_searchEvents);
    super.initState();
  }

  _clearSearch() {
    Provider.of<EventProvider>(context, listen: false).clearSearch();
  }

  _searchEvents() {
    if (textSearchController.text.isNotEmpty) {
      Provider.of<EventProvider>(context, listen: false)
          .searchEventsByName(textSearchController.text);
    } else {
      _clearSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: SizedBox(
                  height: 36,
                  child: TextField(
                    controller: textSearchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      suffixIcon: IconButton(
                        onPressed: () {
                          textSearchController.text = '';
                          _clearSearch();
                        },
                        icon: const Icon(
                                Icons.cancel,
                                color: Color(0xFFF91659),
                                size: 16,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: IconButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, MapEventsScreen.routeName)},
                  icon: const Icon(
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
