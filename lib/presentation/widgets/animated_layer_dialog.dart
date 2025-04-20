import 'package:flutter/material.dart';

class AnimatedLayerBox extends StatefulWidget {
  const AnimatedLayerBox({super.key});

  @override
  State<AnimatedLayerBox> createState() => _AnimatedLayerBoxState();
}

class _AnimatedLayerBoxState extends State<AnimatedLayerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _widthAnimation;
  late final Animation<double> _heightAnimation;

  bool _showLayerOptions = false;
  String _selectedLayer = "Without any layer";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 550),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 0, end: 170).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _heightAnimation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLayerOptions() {
    setState(() {
      _showLayerOptions = !_showLayerOptions;
    });
  }

  void _selectLayer(String layer) async {
      print(_showLayerOptions);
      print(_showLayerOptions);
    setState(() {
      print(layer);
      _selectedLayer = layer;
      _showLayerOptions = false;
       print(_showLayerOptions);
    });

    // Reverse the animation
    await _controller.reverse();

    // Optional: Call any logic here after the animation has finished
    // For example: widget.onLayerSelected?.call(layer);
  }

  Widget _buildLayerOption({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    bool isSelected = _selectedLayer == label;

    return GestureDetector(
      onTap: () => _selectLayer(label),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.grey.shade600,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          bottom: 190,
          left: 16,
          child: Container(
            height: _heightAnimation.value,
            width: _widthAnimation.value,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: _widthAnimation.value > 160
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLayerOption(
                        icon: Icons.check_circle_outline,
                        label: "Cosy areas",
                        color: Colors.green.shade300,
                      ),
                      const SizedBox(height: 16),
                      _buildLayerOption(
                        icon: Icons.attach_money,
                        label: "Price",
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 16),
                      _buildLayerOption(
                        icon: Icons.business,
                        label: "Infrastructure",
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      _buildLayerOption(
                        icon: Icons.layers_clear,
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
