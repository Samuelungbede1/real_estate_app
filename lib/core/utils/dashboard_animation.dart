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

 // Animation for vertical slide (from bottom to top)
perfectPlaceSlide = Tween<Offset>(
  begin: const Offset(0, 1), // Starts off-screen (bottom)
  end: Offset.zero, // Ends at its original position (top)
).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.15, 0.45, curve: Curves.easeIn),
  ),
);

// Animation for fade-in effect (optional)
perfectPlaceFade = Tween<double>(
  begin: 0.78, // Initially invisible
  end: 1.0, // Fully visible when done
).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.10, 0.45, curve: Curves.easeOut),
  ),
);


 revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeInToLinear), // Start reveal later
      ),
    );




scaleOut = Tween<double>(begin: 0.0, end: 1.0).animate(
  CurvedAnimation(
  parent: controller,
  curve: const Interval(
    0.0, // Start at 30% of the animation duration
    1.0,
    curve: Curves.linearToEaseOut,
  ),

  ),
);

 sheetSizeAnimation = Tween<double>(begin: 0.0011, end: 0.6701).animate( // Animate initialChildSize
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.40, 0.65, curve: Curves.easeInOutSine), // Adjust interval as needed
      ),
    );

     bottomNavPosition = Tween<double>(begin: -100, end: 65).animate(
    CurvedAnimation(
      parent: controller,
        curve: const Interval(0.85, 1.00, curve: Curves.easeInOut), // Adjust interval as needed
    ),
  );


    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
