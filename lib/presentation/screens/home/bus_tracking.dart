import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../../models/bus.dart';

class BusTrackingPage extends StatefulWidget {
  final Bus bus;

  const BusTrackingPage({required this.bus, super.key});

  @override
  State<BusTrackingPage> createState() => _BusTrackingPageState();
}

class _BusTrackingPageState extends State<BusTrackingPage> {
  StompClient? stompClient;
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _initializeStompConnection();
  }

  void _initializeStompConnection() {
    stompClient = StompClient(
      config: StompConfig(
        url:
            'wss://unitransit-backend-production.up.railway.app/bus-tracking-websocket',
        onConnect: _onConnect,
        onWebSocketError: (error) {
          debugPrint('WebSocket error: $error');
        },
        onStompError: (frame) {
          debugPrint('STOMP error: ${frame.body}');
        },
        beforeConnect: () async {
          debugPrint('Connecting to WebSocket...');
        },
      ),
    );
    stompClient?.activate();
  }

  void _onConnect(StompFrame frame) {
    debugPrint("Connected to WebSocket");
    stompClient?.subscribe(
      destination: '/topic/bus-tracking/${widget.bus.id}',
      callback: (frame) {
        debugPrint('Received bus tracking data: ${frame.body}');
        _updateBusLocation(frame.body);
      },
    );
  }

  void _updateBusLocation(String? jsonData) {
    if (jsonData == null) return;

    try {
      final Map<String, dynamic> locationData = json.decode(jsonData);
      final double latitude = locationData['latitude'] ?? 0.0;
      final double longitude = locationData['longitude'] ?? 0.0;
      final LatLng newLocation = LatLng(latitude, longitude);

      setState(() {
        _currentLocation = newLocation;

        _markers.clear(); // Clear previous markers
        _markers.add(
          Marker(
            markerId: MarkerId(widget.bus.id),
            position: newLocation,
            infoWindow: InfoWindow(
              title: 'Bus ${widget.bus.id}',
              snippet: 'Latitude: $latitude, Longitude: $longitude',
            ),
          ),
        );
      });

      // Update the map camera position
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(newLocation, 14.0),
      );
    } catch (e) {
      debugPrint('Error parsing bus location data: $e');
    }
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Bus ${widget.bus.id}'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation ?? const LatLng(0, 0),
          zoom: _currentLocation != null ? 14.0 : 3.0,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
