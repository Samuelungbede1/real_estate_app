import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';

class AnimatedOfferCircle extends StatelessWidget {
  final DashboardAnimations animations;

  const AnimatedOfferCircle({
    Key? key,
    required this.animations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animations.controller,
      builder: (context, child) {
        final scale = Tween<double>(begin: 0.0, end: 1.0)
            .animate(
              CurvedAnimation(
                parent: animations.controller,
                curve: const Interval(
                  0.35, // Start at the beginning of the animation
                  0.70,
                  curve: Curves.easeInToLinear,
                ),
              ),
            )
            .value;

        return Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: Container(
            width: 180, // Set width and height to the same value
            height: 180,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(100), // Makes it circular
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
                      '1034',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: false ? Colors.black87 : Colors.white,
                      ),
                    ),
                    // const SizedBox(height: 4),
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