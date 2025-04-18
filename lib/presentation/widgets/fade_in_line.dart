import 'package:flutter/widgets.dart';

class VerticalRevealText extends StatelessWidget {
  final String text;
  final AnimationController controller;
  final Interval interval;
  final TextStyle? style;

  const VerticalRevealText({
    super.key,
    required this.text,
    required this.controller,
    required this.interval,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: interval,
    );

    return Align(
      alignment: Alignment.bottomLeft,
      heightFactor: animation.value, // reveals from top to bottom
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
