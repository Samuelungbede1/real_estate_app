import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/app_colors.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';
import 'package:real_estate_app/core/utils/responsive_screen_functions.dart';

import '../../core/utils/app_text.dart';

class AnimatedOfferCircle extends StatelessWidget {
  final DashboardAnimations animations;

  const AnimatedOfferCircle({
    Key? key,
    required this.animations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
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
            width: Responsive.width(190),
            height: Responsive.height(190),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(Responsive.radius(100)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppText.medium("BUY",
                    fontSize: Responsive.fontSize(16), color: AppColors.white),
                Column(
                  children: [
                    AppText.bold('${countAnimation.value}',
                        fontSize: Responsive.fontSize(32),
                        color: AppColors.white),
                    AppText.regular("offers",
                        fontSize: Responsive.fontSize(15),
                        color: AppColors.white),
                  
                  ],
                ),
                SizedBox(height: Responsive.height(10)),
              ],
            ),
          ),
        );
      },
    );
  }
}
