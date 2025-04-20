import 'package:flutter/widgets.dart';

class MapAnimation {
  late final AnimationController controller;
  late final AnimationController
      markerAnimationController; // Separate controller for markers

  late final Animation<double> fadeAnimation;
  late final Animation<double> slideAnimation;

  late final Animation<double> perfectPlaceFade;
  late final Animation<Offset> perfectPlaceSlide;
  late final Animation<double> revealAnimation;
  late Animation<double> scaleOut;

  late final Animation<double> searchBarScale;
  late final Animation<double> filterIconScale;
  late final Animation<double> searchBarWidth;
  late final Animation<double> markerWidth;
  late final Animation<double> markerHeight;
  late final Animation<double> markerScale;
  // late final Animation<double> dialogWidthAnimation;
  // late final Animation<double>  dialogHeightAnimation;

  // Add these for marker animations
  late final Animation<double> reMarkerWidth;
  late final Animation<double> reMarkerHeight;
  late final Animation<double> reMarkerScale;

  late final Animation<double> dialogClickMarkerWidth;

  MapAnimation(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 5000),
    );

    // Separate controller just for marker animations
    markerAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 850),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Search bar scales from 0 to 1 between 0.1 and 0.3
    searchBarScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.12, 0.3, curve: Curves.linear),
      ),
    );

    // Filter icon scales from 0 to 1 a little after
    filterIconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.12, 0.3, curve: Curves.linear),
      ),
    );

    searchBarWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 0.2, curve: Curves.linear),
      ),
    );

    markerWidth = Tween<double>(begin: 0, end: 60).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.35, 0.5, curve: Curves.easeIn),
      ),
    );

    markerHeight = Tween<double>(begin: 0, end: 35).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.35, 0.5, curve: Curves.easeIn),
      ),
    );

    markerScale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    // Marker animations
    reMarkerWidth = Tween<double>(begin: 0, end: 60).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.1, 0.9, curve: Curves.decelerate),
      ),
    );
    reMarkerHeight = Tween<double>(begin: 35, end: 45).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
    reMarkerScale = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

// Add this to your MapAnimation class

// Dialog click animation - ONLY affects width
    dialogClickMarkerWidth = Tween<double>(begin: 60, end: 30).animate(
      CurvedAnimation(
        parent: markerAnimationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );
    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
