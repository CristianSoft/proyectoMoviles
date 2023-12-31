import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/dtos/event_model.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _originalEvents = [];
  List<Event> _events = [];

  List<Event> get events => _events;

  int get totalEvents => _events.length;

  Future<bool> checkEvents() async {
    if (_events.isEmpty) {
      await _initEventsList();
      return true;
    }
    return false;
  }

  Future<void> _initEventsList() async {
    final querySnapShot =
        await FirebaseFirestore.instance.collection('events').get();

    _events = querySnapShot.docs.map((doc) {
      final data = doc.data();
      return Event(
          id: data['id'],
          eventName: data['eventName'],
          imageUrl: data['imageUrl'],
          date: data['date'],
          description: data['description'],
          latitude: data['latitude'],
          longitude: data['longitude']);
    }).toList();

    _originalEvents = querySnapShot.docs.map((doc) {
      final data = doc.data();
      return Event(
          id: data['id'],
          eventName: data['eventName'],
          imageUrl: data['imageUrl'],
          date: data['date'],
          description: data['description'],
          latitude: data['latitude'],
          longitude: data['longitude']);
    }).toList();

    notifyListeners();
  }

  void clearSearch() {
    _events = [..._originalEvents];
    notifyListeners();
  }

  void searchEventsByName(String name) {
    _events = _originalEvents
          .where((element) => element.eventName.contains(name))
          .toList();
    notifyListeners();
  }
}
