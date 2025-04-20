import 'package:flutter/widgets.dart';
import 'package:real_estate_app/core/utils/assets.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';
import 'package:real_estate_app/presentation/widgets/custom_icon.dart';

class ExpandingProfileIcon extends StatelessWidget {
  final DashboardAnimations animations;

  const ExpandingProfileIcon({
    Key? key,
    required this.animations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animations.controller,
      builder: (context, child) {
        final scale = Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(
              parent: animations.controller,
              curve: const Interval(
                0.0,
                0.20,
                curve: Curves.easeIn,
              ),
            ))
            .value;
        return Transform.scale(
          scale: scale, // This gives the pinch zoom effect
          alignment: Alignment.center,
          child: Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const ClipOval(
              child: CustomIcon(
                fit: BoxFit.fill,
                showImage: true,
                Assets.profileImage,
                size: 50,
              ),
            ),
          ),
        );
      },
    );
  }
}
