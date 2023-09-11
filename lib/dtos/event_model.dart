class Event {
  int id;
  String eventName;
  String imageUrl;
  String date;
  String description;
  double latitude;
  double longitude;

  Event(
      {required this.id,
      required this.eventName,
      required this.imageUrl,
      required this.date,
      required this.description,
      required this.latitude,
      required this.longitude});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        eventName: json['eventName'],
        imageUrl: json['sprites']['imageUrl'],
        date: json['date'],
        description: json['description'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }

  factory Event.fromFirebaseJson(Map<String, dynamic> json) => Event(
      id: json['id'],
      eventName: json['eventName'],
      imageUrl: json['imageUrl'],
      date: json['date'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude']);

  Map<String, Object> toJson() => {
        'id': id,
        'eventName': eventName,
        'imageUrl': imageUrl,
        'date': date,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
      };
}
