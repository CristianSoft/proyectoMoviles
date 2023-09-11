import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';

class MapEventsScreen extends StatefulWidget {
  static const routeName = '/map';
  const MapEventsScreen({super.key});

  @override
  State<MapEventsScreen> createState() => _MapEventsScreenState();
}

class _MapEventsScreenState extends State<MapEventsScreen> {
  Location location = Location();
  LatLng _center = const LatLng(-0.181031, -78.484054);
  bool? _serviceEnabled;
  PermissionStatus? _permissionStatus;
  LocationData? _locationData;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    markers.add(const Marker(
      markerId: MarkerId('0'),
      position: LatLng(-0.211645, -78.489151),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'PoliFest',
        snippet: 'Septimebre 8',
      ),
    ));

    markers.add(const Marker(
      markerId: MarkerId('1'),
      position: LatLng(-0.202107, -78.492755),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'TropicalFest',
        snippet: 'Septiembre 9',
      ),
    ));

    markers.add(const Marker(
      markerId: MarkerId('2'),
      position: LatLng(-0.21231, -78.490309),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Poli 10k',
        snippet: 'Septiembre 22',
      ),
    ));

    markers.add(const Marker(
      markerId: MarkerId('3'),
      position: LatLng(-0.209338, -78.487037),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: 'Yincana EPN',
        snippet: 'Septiembre 29',
      ),
    ));
  }

  Future<void> initialLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> localDevice() async {
    _locationData = await location.getLocation();
    setState(() {
      _center = LatLng(_locationData!.latitude!, _locationData!.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Map'),
      ),
      body: FutureBuilder(
        future: initialLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(target: _center, zoom: 14),
              markers: markers,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => localDevice(),
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
