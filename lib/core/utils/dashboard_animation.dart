import 'package:flutter/widgets.dart';

class DashboardAnimations {
  late final AnimationController controller;
  late final Animation<double> fadeAnimation;
  late final Animation<double> slideAnimation;

  late final Animation<double> perfectPlaceFade;
  late final Animation<Offset> perfectPlaceSlide;
  late final Animation<double> revealAnimation;
  late Animation<double> scaleOut;
  late final Animation<double> sheetSizeAnimation;
  late final Animation<double> bottomNavPosition;

  DashboardAnimations(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 6000),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 1, curve: Curves.easeInOut),
      ),
    );

    perfectPlaceSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.15, 0.45, curve: Curves.easeIn),
      ),
    );

    perfectPlaceFade = Tween<double>(
      begin: 0.78,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.10, 0.45, curve: Curves.easeOut),
      ),
    );

    revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeInToLinear),
      ),
    );

    scaleOut = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.linearToEaseOut,
        ),
      ),
    );

    sheetSizeAnimation = Tween<double>(begin: 0.0011, end: 0.6701).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.40, 0.65, curve: Curves.easeInOutSine),
      ),
    );

    bottomNavPosition = Tween<double>(begin: -100, end: 65).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.85, 1.00, curve: Curves.easeInOut),
      ),
    );

    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
