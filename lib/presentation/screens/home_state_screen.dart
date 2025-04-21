import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';
import 'package:real_estate_app/presentation/screens/dasboard_screen.dart';
import 'package:real_estate_app/presentation/screens/map_screen.dart';

import '../widgets/ripple_animation.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  _HomeScreenStateState createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState>
    with TickerProviderStateMixin {
  int _selectedIndex = 2;

  late DashboardAnimations animations;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    animations = DashboardAnimations(this);
    _fadeController = AnimationController(
      
      duration: const Duration(milliseconds: 1500),
      vsync: this,
      
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();
  }

  @override
  void dispose() {
    animations.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  final List<Widget> _screens = [
    const MapScreen(),
    const DashboardScreen(),
    const DashboardScreen(),
    const DashboardScreen(),
    const MapScreen(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }


   void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      _fadeController.reset();
      setState(() => _selectedIndex = index);
      _fadeController.reverse();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: _screens[_selectedIndex],
        ),
        // _screens[_selectedIndex],
        AnimatedBuilder(
          animation: animations.controller,
          builder: (context, child) {
            return Positioned(
              bottom: animations.bottomNavPosition.value,
              left: 70,
              right: 70,
              child: child!,
            );
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.circle, _selectedIndex == 0),
                _buildNavItem(1, Icons.messenger_outlined, _selectedIndex == 1),
                _buildNavItem(2, Icons.home_filled, _selectedIndex == 2),
                _buildNavItem(3, Icons.favorite, _selectedIndex == 3),
                _buildNavItem(4, Icons.person_2_sharp, _selectedIndex == 4),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildNavItem(int index, IconData icon, bool isSelected) {
    return RippleAnimation(
      onTap: () => setState(() => _selectedIndex = index),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
              width: isSelected ? 45 : 38,
              height: isSelected ? 45 : 38,
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
