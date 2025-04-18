import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';

class AnimatedRentWidget extends StatelessWidget {
  final DashboardAnimations animations;

  const AnimatedRentWidget({
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

        return Expanded(
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.center,
            child: Container(
              height: 180,
              // width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "RENT",
                      style: TextStyle(
                        color: Colors.brown,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '2,212',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "offers",
                          style: TextStyle(
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}