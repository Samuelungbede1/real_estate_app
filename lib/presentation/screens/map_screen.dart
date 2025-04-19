import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  // Sample marker locations for Saint Petersburg
  final List<LatLng> _markerLocations = [
    LatLng(59.9343, 30.3351), // Center
    LatLng(59.9398, 30.3006), // Peter and Paul Fortress
    LatLng(59.9339, 30.3061), // Hermitage
    LatLng(59.9339, 30.3171), // Hermitage
    LatLng(59.9250, 30.2958), // Mariinsky Theatre
    LatLng(59.9250, 30.3171), // Mariinsky Theatre
    LatLng(59.9127, 30.3010), // St. Isaac's Cathedral
    LatLng(59.9400, 30.3208), // Church of the Savior on Blood
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter:
                  LatLng(59.9339, 30.3061), // Saint Petersburg coordinates
              initialZoom: 14.0,
              minZoom: 14.0,
              maxZoom: 28.0,
              backgroundColor: Colors.black,
            ),
            children: [
              TileLayer(
                maxZoom: double.infinity,
                retinaMode: true,
                // urlTemplate: 'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}.png',

                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.app',

                // urlTemplate:
                //     'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                // subdomains: const ['a', 'b', 'c'],
                // userAgentPackageName: 'com.example.app',
                // backgroundColor: Colors.black,
              ),
              MarkerLayer(
                markers: _markerLocations
                    .map((point) => Marker(
                        width: 30.0,
                        height: 35.0,
                        point: point,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(0), // sharp edge
                            ),
                          ),
                          child: const Icon(
                            Icons.business,
                            color: Colors.white,
                            size: 20,
                          ),
                        )))
                    .toList(),
              ),
            ],
          ),

          // Status bar area
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.black.withOpacity(0.5),
          ),

          // Search bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Row(
                      children: [
                         Icon(Icons.search, color: Colors.grey),
                         SizedBox(width: 8),
                         Text(
                          'Saint Petersburg',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.tune, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 140,
            left: 16,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.layers_outlined, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.navigation_outlined, color: Colors.white),
                ),
              ],
            ),
          ),

          // List of variants button
          Positioned(
            bottom: 140,
            right: 16,
            child: Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.list, color: Colors.grey.shade300),
                  const SizedBox(width: 8),
                  Text(
                    'List of variants',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
