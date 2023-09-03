class Event {
  int id;
  String eventName;
  String imageUrl;
  String date;

  Event(
      {required this.id,
      required this.eventName,
      required this.imageUrl,
      required this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        eventName: json['eventName'],
        imageUrl: json['sprites']['imageUrl'],
        date: json['date']);
  }

  factory Event.fromFirebaseJson(Map<String, dynamic> json) => Event(
      id: json['id'],
      eventName: json['eventName'],
      imageUrl: json['imageUrl'],
      date: json['date']);

  Map<String, Object> toJson() => {
        'id': id,
        'eventName': eventName,
        'imageUrl': imageUrl,
        'date': date,
      };
}
