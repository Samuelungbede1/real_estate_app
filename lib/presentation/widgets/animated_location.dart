import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_text.dart';
import '../../core/utils/responsive_screen_functions.dart';

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
 Responsive.init(context);

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

        var minWidth =  2 + expandProgress;
        final maxWidth =  MediaQuery.of(context).size.width * 0.42;
        final currentWidth = minWidth + (maxWidth - minWidth) * expandProgress;

        return SizedBox(
          height:  Responsive.height(45),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: currentWidth,
            padding: EdgeInsets.only(
              left: Responsive.width(16),
              right:  Responsive.width(16 * expandProgress),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Responsive.radius(12)),
            ),
            child: ClipRect(
              child: LayoutBuilder(
                builder: (context, constraints) {
                
                  final showContent = contentVisibility > 0 && constraints.maxWidth > 30;
                  
                  return Row(
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      if (showContent) 
                        AnimatedOpacity(
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                          opacity: contentVisibility,
                          child:  Icon(
                            Icons.location_on_rounded,
                            size: Responsive.fontSize(18),
                            color: AppColors.brown,
                          ),
                        ),
                      if (showContent) const SizedBox(width: 6),
                      if (showContent)
                        Flexible(
                          child: AnimatedOpacity(
                            curve: Curves.ease,
                            duration: const Duration(milliseconds: 600),
                            opacity: contentVisibility,
                            child: 
                            
                            AppText.medium(widget.location,
                                fontSize: Responsive.fontSize(13), 
                                color: AppColors.brown,
                                overflow: TextOverflow.ellipsis,
                                lines: 1
                                ),
                      
                      ),
                            // Text(
                            //   widget.location,
                            //   style:  TextStyle(
                            //     color: Colors.brown,
                            //     fontSize: Responsive.fontSize(12),
                            //   ),
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 1,
                            // ),
                          ),
                        
                
                  ]); 
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
