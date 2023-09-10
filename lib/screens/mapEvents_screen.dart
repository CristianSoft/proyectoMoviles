import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapEventsScreen extends StatefulWidget {
  static const routeName = '/map';
  const MapEventsScreen({super.key});

  @override
  State<MapEventsScreen> createState() => _MapEventsScreenState();
}

class _MapEventsScreenState extends State<MapEventsScreen> {
  Location location = Location();
  LatLng _center = const LatLng(-0.103149, -78.448075);
  bool? _serviceEnabled;
  PermissionStatus? _permissionStatus;
  LocationData? _locationData;
  Set<Marker> markers = {};

  // @override
  // void initState() {
  //   super.initState();
  //   markers.add(const Marker(
  //       markerId: MarkerId('1'), 
  //       position: LatLng(-0.103149, -78.448075))
  //     );
  // }

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
