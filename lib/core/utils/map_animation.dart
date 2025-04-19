import 'package:flutter/widgets.dart';

class MapAnimation {
  late final AnimationController controller;
  late final Animation<double> fadeAnimation;
  late final Animation<double> slideAnimation;

  late final Animation<double> perfectPlaceFade;
  late final Animation<Offset> perfectPlaceSlide;
  late final Animation<double> revealAnimation;
  late Animation<double> scaleOut;

  late final Animation<double> searchBarScale;
  late final Animation<double> filterIconScale;
  late final Animation<double> searchBarWidth;

  MapAnimation(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 4000),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
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


      final scale = Tween<double>(begin: 0.0, end: 1.0)
    .animate(CurvedAnimation(
  parent: controller,
  curve: const Interval(
    0.0, // Start at 30% of the animation duration
    0.20,
    curve: Curves.easeIn,
  ),
)).value;

    

    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
