import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/app_colors.dart';
import 'package:real_estate_app/core/utils/assets.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';
import 'package:real_estate_app/presentation/screens/dasboard_screen.dart';
import 'package:real_estate_app/presentation/screens/map_screen.dart';
import 'package:real_estate_app/presentation/widgets/custom_icon.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  _HomeScreenStateState createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;

  late DashboardAnimations animations;

  @override
  void initState() {
    super.initState();
    animations = DashboardAnimations(this); // 'this' is the TickerProvider
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  final List<Widget> _screens = [
    const MapScreen(),
    const DashboardScreen(),
    const DashboardScreen(),
    const DashboardScreen(),
    const MapScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _screens[_selectedIndex],
        AnimatedBuilder(
          animation: animations.controller,
          builder: (context, child) {
            return Positioned(
              bottom: animations.bottomNavPosition.value,
              left: 80,
              right: 80,
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
                _buildNavItem(0, Icons.search_rounded, _selectedIndex == 0),
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
    return GestureDetector(
      onTap: () {
        // _selectedIndex = index;

        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
