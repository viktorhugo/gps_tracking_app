import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_tracking/models/message_models.dart';
import 'package:gps_tracking/services/web_socket_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late WebSocketService wssService;

  @override
  void initState() {
    super.initState();
    initSocket();
    getLocationUpdates();
  }

  void initSocket() {
    wssService = Provider.of<WebSocketService>(context, listen: false);
    wssService.startWSSConnection(); 
  }



  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable the services')
        )
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> getLocationUpdates() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    const locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position position) {
        print(position);
        wssService.handleSendMessage(
          event:  "user-send-location",
          data: LocationRequestMessage(
            latitude: position.latitude,
            longitude: position.longitude,
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final socketService = Provider.of<WebSocketService>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.secondary,
        title: const Text('Location Tracking App'),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == WebSocketServerStatus.online 
              ? const Icon( Icons.check_circle, color: Colors.blue, size: 26 )
              : const Icon( Icons.offline_bolt, color: Colors.red, size: 26 ),
          )
        ],
      ),
      body: const Center(child: Text("Location Tracking App Body"))
    );
  }
}