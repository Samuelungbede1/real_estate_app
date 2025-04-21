import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/core/utils/map_animation.dart';
import 'package:real_estate_app/core/utils/string_constants.dart';
import 'package:real_estate_app/presentation/widgets/animated_layer_dialog.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_text.dart';
import '../../core/utils/responsive_screen_functions.dart';
import '../providers/property_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  late MapAnimation animation;

  bool _showLayerOptions = false;
  String _selectedLayer = "Without any layer";
 late IconData _selectedIcon = Icons.layers;

  @override
  void initState() {
    super.initState();
    animation = MapAnimation(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animation.controller.forward();
      context.read<PropertyProvider>().fetchProperties();
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void _toggleLayerOptions() {
    animation.markerAnimationController.reverse();
    print('tap');
    setState(() {
      print('tap');
      _showLayerOptions = !_showLayerOptions;
    });
  }

  void _selectLayer(String layer) {
    setState(() {
      _selectedLayer = layer;
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final propertyProvider = context.watch<PropertyProvider>();

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(
                  propertyProvider.properties[1].location.latitude,
                  propertyProvider.properties[1].location.longitude),
              initialZoom: 14.0,
              minZoom: 14.0,
              maxZoom: 28.0,
              backgroundColor: Colors.black,
            ),
            children: [
              TileLayer(
                maxZoom: double.infinity,
                retinaMode: true,
                urlTemplate: StringConstants.mapUrlTemplate,
                subdomains: StringConstants.subdomains,
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                rotate: true,
                markers: propertyProvider.properties
                    .map(
                      (point) => Marker(
                        width: 60,
                        height: 35,
                        point: LatLng(
                            point.location.latitude, point.location.longitude),
                        child: AnimatedBuilder(
                          animation: Listenable.merge([
                            animation.controller,
                            animation.markerAnimationController
                          ]),
                          builder: (context, child) {
                            double width;
                            if (animation.controller.status ==
                                AnimationStatus.forward) {
                              width = animation.markerWidth.value;
                            } else if (animation
                                        .markerAnimationController.status ==
                                    AnimationStatus.forward ||
                                animation.markerAnimationController.status ==
                                    AnimationStatus.completed) {
                              width = animation.dialogClickMarkerWidth.value;
                            } else {
                              width = animation.dialogClickMarkerWidth.value;
                            }

                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: width,
                                height: animation.markerHeight.value,
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
                                      child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        transitionBuilder: (Widget child,
                                            Animation<double> animation) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: ScaleTransition(
                                              scale: animation,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: (animation
                                                        .markerAnimationController
                                                        .status ==
                                                    AnimationStatus.forward ||
                                                animation
                                                        .markerAnimationController
                                                        .status ==
                                                    AnimationStatus.completed)
                                            ? const Icon(
                                                size: 14,
                                                Icons.business,
                                                color: Colors.white,
                                                key: ValueKey('business-icon'),
                                              )
                                            : Text(
                                                point.location.label,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                                overflow: TextOverflow.ellipsis,
                                                key: const ValueKey(
                                                    'label-text'),
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
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: Responsive.width(18),
            right: Responsive.width(18),
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
                          height: Responsive.height(45),
                          padding: EdgeInsets.symmetric(
                              horizontal: Responsive.width(16)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Responsive.radius(25)),
                          ),
                          child: Row(
                            children: [
                              FadeTransition(
                                opacity: animation.searchBarScale,
                                child: const Icon(Icons.search,
                                    color: Colors.grey),
                              ),
                              SizedBox(width: Responsive.width(8)),
                              Expanded(
                                child: FadeTransition(
                                  opacity: animation.searchBarWidth,
                                  child: AppText.regular(
                                    StringConstants.saintPetersburg,
                                    fontSize: Responsive.fontSize(15),
                                    color: AppColors.black,
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
                SizedBox(width: Responsive.width(10)),
                AnimatedBuilder(
                  animation: animation.controller,
                  builder: (context, child) {
                    return ScaleTransition(
                      scale: animation.filterIconScale,
                      alignment: Alignment.center,
                      child: Container(
                        height: Responsive.height(45),
                        width: Responsive.width(45),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(Responsive.radius(25)),
                        ),
                        child: const Icon(Icons.tune, color: AppColors.grey400),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 140,
            left: Responsive.width(16),
            child: Column(
              children: [
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
                          height: Responsive.height(45),
                          width: Responsive.width(45),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            shape: BoxShape.circle,
                          ),
                          child:  Icon(
                            _selectedIcon,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Responsive.width(10)),
                AnimatedBuilder(
                  animation: animation.controller,
                  builder: (context, child) {
                    return ScaleTransition(
                      scale: animation.filterIconScale,
                      alignment: Alignment.center,
                      child: Container(
                        height: Responsive.height(45),
                        width: Responsive.width(45),
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
          if (_showLayerOptions)
            AnimatedLayerBox(
              markerController: animation.markerAnimationController,
              selectedLayer: _selectedLayer,
              onLayerSelected: (layer, icon) {
                print('Selected: $layer with icon $icon}');
                animation.markerAnimationController.forward();
                setState(() {
                  _selectedIcon = icon;
                  _selectedLayer = layer;
                  _showLayerOptions = false;
                });
              },
              isVisible: _showLayerOptions,
            ),
          Positioned(
            bottom: 145,
            right: 16,
            child: AnimatedBuilder(
              animation: animation.controller,
              builder: (context, child) {
                return ScaleTransition(
                  scale: animation.searchBarScale,
                  alignment: Alignment.center,
                  child: Container(
                    height: Responsive.height(35),
                    padding:
                        EdgeInsets.symmetric(horizontal: Responsive.width(8)),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius:
                          BorderRadius.circular(Responsive.radius(20)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.list, color: AppColors.grey300),
                        SizedBox(width: Responsive.width(8)),
                        AppText.regular(StringConstants.listOfVariant,
                            fontSize: Responsive.fontSize(12),
                            color: AppColors.grey300),
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
}
