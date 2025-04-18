import 'package:flutter/material.dart';
// import 'dart:math' as math;

class AnimatedAddressIndicator extends StatefulWidget {
  final String address;
  final VoidCallback onTap;
  final double height;
  final double borderRadius;
  final double buttonSize;
  final EdgeInsetsGeometry padding;

  const AnimatedAddressIndicator({
    Key? key,
    required this.address,
    required this.onTap,
    this.height = 52,
    this.borderRadius = 40,
    this.buttonSize = 50,
    this.padding = const EdgeInsets.only(left: 16, right: 16, bottom: 8),
  }) : super(key: key);

  @override
  State<AnimatedAddressIndicator> createState() =>
      _AnimatedAddressIndicatorState();
}

class _AnimatedAddressIndicatorState
    extends State<AnimatedAddressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void startAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fullWidth = constraints.maxWidth;
          final buttonSize = widget.buttonSize;

          return SizedBox(
            height: widget.height,
            width: fullWidth,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final progress = _animation.value;

                // Calculate the width of the container as it expands
                final containerWidth =
                    buttonSize + (fullWidth - buttonSize) * progress;

                return Stack(
                  children: [
                    // Background container that expands from left to right
                    Positioned(
                      left: 0, // Fixed left position
                      child: Container(
                        width: containerWidth,
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.65),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.only(left: 20, right: 60),
                        alignment: Alignment.centerLeft,
                        child: Opacity(
                          opacity: progress,
                          child: Text(
                            widget.address,
                            style: const TextStyle(
                              color: Color(0xFF4A4A4A),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),

                    // Button that moves with the expanding edge
                    // Button that moves with the expanding edge
                    Positioned(
                      left: containerWidth - widget.buttonSize + 2,
                      top: (widget.height - widget.buttonSize) + 1,
                      child: GestureDetector(
                        onTap: () {
                          startAnimation();
                          widget.onTap();
                        },
                        child: Container(
                          width: widget.buttonSize - 4,
                          height: widget.buttonSize - 4,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.black54,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
