import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate_app/core/utils/map_animation.dart';
import 'package:real_estate_app/presentation/widgets/animated_layer_dialog.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  final MapController _mapController = MapController();
  late MapAnimation animation;

  bool _showLayerOptions = false;
  String _selectedLayer = "Without any layer";

  @override
  void initState() {
    super.initState();
    animation = MapAnimation(this); // 'this' is the TickerProvider

    // Ensure animation starts after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animation.controller.forward();
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  final List<LocationMarker> _markerLocations = const [
    LocationMarker(latLong: LatLng(59.9343, 30.3351), label: "13,mnp"),
    LocationMarker(latLong: LatLng(59.9398, 30.3006), label: "11 mnp"),
    LocationMarker(latLong: LatLng(59.9339, 30.3061), label: "7,3 mnp"),
    LocationMarker(latLong: LatLng(59.9339, 30.3171), label: "10,4 mnp"),
    LocationMarker(latLong: LatLng(59.9350, 30.2958), label: "4,0 mnp"),
    LocationMarker(latLong: LatLng(59.9250, 30.3171), label: "8 mnp"),
    LocationMarker(latLong: LatLng(59.9309, 30.3010), label: "12,0 mnp"),
    LocationMarker(latLong: LatLng(59.9340, 30.3308), label: "20,9 mnp"),
  ];

  void _toggleLayerOptions() {
    print('tap');
    setState(() {
      print('tap');
      _showLayerOptions = !_showLayerOptions;
    });
  }

  void _selectLayer(String layer) {
    setState(() {
      _selectedLayer = layer;
      // _showLayerOptions = false;
    });
    // Here you would implement the logic to change the map layer
  }

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
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                rotate: true,
                markers: _markerLocations
                    .map(
                      (point) => Marker(
                        width: 60, // Fixed outer width
                        height: 35,
                        point: point.latLong,
                        child: AnimatedBuilder(
                          animation:
                              animation.controller, // Use controller directly
                          builder: (context, child) {
                            // Debug print to verify animation is running
                            // print('Marker animation value: ${animation.widthAnimation.value}');

                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: animation.widthAnimation.value,
                                height: animation.heightAnimation.value,
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    
                                    Flexible(
                                      child: FadeTransition(
                                        opacity: animation.fadeAnimation,
                                        child: Text(
                                          point.label,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),

          // Search bar and other UI elements remain the same
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: AnimatedBuilder(
                    animation: animation.controller,
                    builder: (context, child) {
                      return ScaleTransition(
                        scale: animation.searchBarScale,
                        alignment: Alignment.center,
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              FadeTransition(
                                opacity: animation.searchBarScale,
                                child: const Icon(Icons.search,
                                    color: Colors.grey),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: FadeTransition(
                                  opacity: animation.searchBarWidth,
                                  child: const Text(
                                    'Saint Petersburg',
                                    style:  TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                // Animated Filter/Tune Button
                AnimatedBuilder(
                  animation: animation.controller,
                  builder: (context, child) {
                    return ScaleTransition(
                      scale: animation.filterIconScale,
                      alignment: Alignment.center,
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(Icons.tune, color: Colors.grey),
                      ),
                    );
                  },
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
                // Layer button - Fixed version
                GestureDetector(
                  onTap: () {
                    print('TAPPED - Layer Button');
                    _toggleLayerOptions();
                  },
                  child: AnimatedBuilder(
                    animation: animation.controller,
                    builder: (context, child) {
                      return ScaleTransition(
                        scale: animation.filterIconScale,
                        alignment: Alignment.center,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.layers_outlined,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // Navigation button
                AnimatedBuilder(
                  animation: animation.controller,
                  builder: (context, child) {
                    return ScaleTransition(
                      scale: animation.filterIconScale,
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.navigation_outlined,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          if (_showLayerOptions) const AnimatedLayerBox(),

          // List of variants button
          Positioned(
            bottom: 140,
            right: 16,
            child: AnimatedBuilder(
              animation: animation.controller,
              builder: (context, child) {
                return ScaleTransition(
                  scale: animation.searchBarScale,
                  alignment: Alignment.center,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerOption({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    bool isSelected = _selectedLayer == label;

    return GestureDetector(
      onTap: () => _selectLayer(label),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey.shade600,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class LocationMarker {
  final LatLng latLong;
  final String label;

  const LocationMarker({required this.latLong, required this.label});
}
