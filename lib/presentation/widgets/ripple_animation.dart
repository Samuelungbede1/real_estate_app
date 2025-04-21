import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double size;

  const RippleAnimation({
    super.key,
    required this.child,
    this.onTap,
    this.size = 50,
  });

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _innerRadius;
  late Animation<double> _outerRadius;
  late Animation<double> _opacity;
  late Animation<double> _innerStroke;
  late Animation<double> _outerStroke;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _innerRadius = Tween<double>(begin: 3, end: widget.size * 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _outerRadius =
        Tween<double>(begin: widget.size * 0.15, end: widget.size * 0.32)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeInOutBack),
      ),
    );

    _opacity = Tween<double>(begin: 0.6, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Stroke width animations
    _innerStroke = Tween<double>(begin: 0, end: 6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _outerStroke = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.4, curve: Curves.easeOut),
      ),
    );
  }

  void _handleTap() {
    _controller.forward(from: 0).then((_) {
      _controller.reverse();
      widget.onTap?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RipplePainter(
                  innerRadius: _innerRadius.value,
                  outerRadius: _outerRadius.value,
                  opacity: _opacity.value,
                  innerStroke: _innerStroke.value,
                  outerStroke: _outerStroke.value,
                ),
              );
            },
          ),
          widget.child,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _RipplePainter extends CustomPainter {
  final double innerRadius;
  final double outerRadius;
  final double opacity;
  final double innerStroke;
  final double outerStroke;

  _RipplePainter({
    required this.innerRadius,
    required this.outerRadius,
    required this.opacity,
    required this.innerStroke,
    required this.outerStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Outer circle
    final outerPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerStroke;

    // Inner circle
    final innerPaint = Paint()
      ..color =Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = innerStroke;

    canvas.drawCircle(center, outerRadius, outerPaint);
    canvas.drawCircle(center, innerRadius, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _RipplePainter oldDelegate) {
    return innerRadius != oldDelegate.innerRadius ||
        outerRadius != oldDelegate.outerRadius ||
        opacity != oldDelegate.opacity ||
        innerStroke != oldDelegate.innerStroke ||
        outerStroke != oldDelegate.outerStroke;
  }
}
