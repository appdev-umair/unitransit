import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:unitransit/core/constants/animation_constant.dart';
import 'package:unitransit/core/constants/url_constant.dart';
import 'package:unitransit/presentation/screens/home/bus_tracking.dart';

import '../../../models/bus.dart';
import '../../../models/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Dio dio = Dio();
  List<Routes> routes = [];
  List<Bus> buses = [];
  String? selectedRouteId;
  String? selectedBusId;

  @override
  void initState() {
    super.initState();
    fetchRoutes();
  }

  Future<void> fetchRoutes() async {
    try {
      final response = await dio.get('${URLConstant.baseUrl}/public/routes');
      setState(() {
        routes = (response.data as List)
            .map((routeData) => Routes.fromJson(routeData))
            .toList();
      });
    } catch (error) {
      debugPrint('Error fetching routes: $error');
    }
  }

  Future<void> fetchBusesByRoute(String routeId) async {
    try {
      final response =
          await dio.get('${URLConstant.baseUrl}/public/buses/$routeId');
      setState(() {
        buses = (response.data as List)
            .map((busData) => Bus.fromJson(busData))
            .toList();

        selectedBusId = null; // Reset selected bus when route changes
      });
    } catch (error) {
      debugPrint('Error fetching buses: $error');
    }
  }

  void trackBus(Bus bus) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusTrackingPage(bus: bus),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Routes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for selecting routes
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Route',
                border: OutlineInputBorder(),
              ),
              value: selectedRouteId,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              items: routes.map<DropdownMenuItem<String>>((route) {
                return DropdownMenuItem<String>(
                  value: route.id,
                  child: Text(
                    '${route.routeName} (${route.startLocation} → ${route.endLocation})',
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRouteId = value;
                });
                fetchBusesByRoute(value!);
              },
            ),
            const SizedBox(height: 20),
            // Display buses or show a message
            Expanded(
              child: buses.isEmpty
                  ? Center(
                      child: Lottie.asset(AnimationConstant.bus),
                    )
                  : ListView.builder(
                      itemCount: buses.length,
                      itemBuilder: (context, index) {
                        final bus = buses[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  bus.isOperational ? Colors.green : Colors.red,
                              child: Icon(
                                bus.isOperational ? Icons.check : Icons.close,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'Bus: ${bus.busNumber}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Type: ${bus.type}'),
                                Text('Plate: ${bus.plateNumber}'),
                              ],
                            ),
                            trailing: ElevatedButton.icon(
                              onPressed: () {
                                trackBus(bus);
                              },
                              icon: const Icon(Icons.gps_fixed),
                              label: const Text('Track'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
