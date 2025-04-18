import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';

class ExpandingLocationWidget extends StatefulWidget {
  final String location;
  final DashboardAnimations animations;

  const ExpandingLocationWidget({
    super.key,
    required this.location,
    required this.animations,
  });

  @override
  State<ExpandingLocationWidget> createState() =>
      _ExpandingLocationWidgetState();
}

class _ExpandingLocationWidgetState extends State<ExpandingLocationWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animations.controller,
      builder: (context, child) {
        final expandProgress = CurvedAnimation(
          parent: widget.animations.controller,
          curve: const Interval(
            0.0,
            0.20,
            curve: Curves.easeIn,
          ),
        ).value;

        final contentVisibility = (expandProgress - 0.8).clamp(0.0, 1.0) / 0.2;

        var minWidth = 2 + expandProgress;
        final maxWidth = MediaQuery.of(context).size.width * 0.4;
        final currentWidth = minWidth + (maxWidth - minWidth) * expandProgress;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 45,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: currentWidth,
              padding: EdgeInsets.only(
                left: 16,
                right: 16 * expandProgress, // Make sure padding scales with width
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  // BoxShadow(
                  //   color: Colors.grey.withOpacity(0.1 * expandProgress),
                  //   blurRadius: 10 * expandProgress,
                  // ),
                ],
              ),
              child: ClipRect(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Only show content when there's enough space
                    final showContent = contentVisibility > 0 && constraints.maxWidth > 30;
                    
                    return Row(
                      mainAxisSize: MainAxisSize.min, // Important: Use minimum space
                      children: [
                        if (showContent) 
                          AnimatedOpacity(
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 300),
                            opacity: contentVisibility,
                            child: const Icon(
                              Icons.location_on_rounded,
                              size: 16,
                              color: Colors.brown,
                            ),
                          ),
                        if (showContent) const SizedBox(width: 6),
                        if (showContent)
                          Flexible(
                            child: AnimatedOpacity(
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 600),
                              opacity: contentVisibility,
                              child: Text(
                                widget.location,
                                style: const TextStyle(
                                  color: Colors.brown,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis, // Add this to prevent text overflow
                                maxLines: 1,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
