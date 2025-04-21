import 'package:flutter/material.dart';

import '../../core/utils/responsive_screen_functions.dart';

class AnimatedLayerBox extends StatefulWidget {
  final String selectedLayer;
  final Function(String label) onLayerSelected;
  final bool isVisible;
  final AnimationController? markerController;

  const AnimatedLayerBox({
    super.key,
    required this.selectedLayer,
    required this.onLayerSelected,
    required this.isVisible,
    this.markerController,
  });

  @override
  State<AnimatedLayerBox> createState() => _AnimatedLayerBoxState();
}

class _AnimatedLayerBoxState extends State<AnimatedLayerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _widthAnimation;
  late final Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _heightAnimation = Tween<double>(begin: 0, end: 160).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedLayerBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      widget.isVisible ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleLayerSelection(String label) async {
    await _controller.reverse();
    //  widget.markerController!.reverse();

    // Pass both the selected label AND our animation controller
    // This allows the parent to synchronize with our animation
    widget.onLayerSelected(label);

    // If marker controller was passed, we can also start it directly
    widget.markerController?.forward();
  }

  Widget _buildLayerOption({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    bool isSelected = widget.selectedLayer == label;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon,
            color: isSelected ? Colors.orange : Colors.grey.shade600, size: Responsive.fontSize(15)),
         SizedBox(width: Responsive.width(12)),
        GestureDetector(
          onTap: () => _handleLayerSelection(label),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey.shade600,
              fontSize: Responsive.fontSize(11),
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, widget.markerController]),
      // animation: _controller,
      builder: (context, child) {
        return Positioned(
          bottom: 205,
          left: 20,
          child: Container(
            height: Responsive.height(_heightAnimation.value),
            width: Responsive.width(_widthAnimation.value),
            padding: EdgeInsets.symmetric(
                vertical: Responsive.width(12),
                horizontal: Responsive.height(10)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Responsive.radius(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: Responsive.radius(10),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: _widthAnimation.value > 140
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildLayerOption(
                        icon: Icons.check_circle_outline,
                        label: "Cosy areas",
                        color: Colors.green.shade300,
                      ),
                      SizedBox(height: Responsive.height(16)),
                      _buildLayerOption(
                        icon: Icons.wallet,
                        label: "Price",
                        color: Colors.orange,
                      ),
                      SizedBox(height: Responsive.height(16)),
                      _buildLayerOption(
                        icon: Icons.network_ping_sharp,
                        label: "Infrastructure",
                        color: Colors.grey,
                      ),
                      SizedBox(height: Responsive.height(16)),
                      _buildLayerOption(
                        icon: Icons.layers,
                        label: "Without any layer",
                        color: Colors.grey,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
