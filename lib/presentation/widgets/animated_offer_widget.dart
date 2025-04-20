import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';

class AnimatedOfferCircle extends StatelessWidget {
  final DashboardAnimations animations;

  const AnimatedOfferCircle({
    Key? key,
    required this.animations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countAnimation = IntTween(begin: 0, end: 1034).animate(
      CurvedAnimation(
        parent: animations.controller,
        curve: const Interval(
          0.25,
          0.55,
          curve: Curves.linearToEaseOut,
        ),
      ),
    );

    final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animations.controller,
        curve: const Interval(
          0.30,
          0.45,
          curve: Curves.easeIn,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animations.controller,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          alignment: Alignment.center,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Buy",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${countAnimation.value}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "offers",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
