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
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;

  late DashboardAnimations animations;

  @override
  void initState() {
    super.initState();
    animations = DashboardAnimations(this);
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

  // Widget _buildNavItem(int index, IconData icon, bool isSelected) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         _selectedIndex = index;
  //       });
  //     },
  //     child: isSelected ?Container(
  //       width: 45,
  //       height: 45,
  //       decoration: const BoxDecoration(
  //         color:  Colors.orange,
  //         shape: BoxShape.circle,
  //       ),
  //       child: Icon(
  //         icon,
  //         color: isSelected ? Colors.white : Colors.white,
  //         size: 20,
  //       ),
  //     ): Container(
  //       width: 38,
  //       height: 38,
  //       decoration: const BoxDecoration(
  //         color:  Colors.black26,
  //         shape: BoxShape.circle,
  //       ),
  //       child: Icon(
  //         icon,
  //         color: isSelected ? Colors.white : Colors.white,
  //         size: 20,
  //       ),
  //     ),
  //   );
  // }
// Widget _buildNavItem(int index, IconData icon, bool isSelected) {
//   return Material(
//     color: Colors.transparent,
//     child: Stack(
//       alignment: Alignment.center,
//       children: [
//         // Background container
//         Container(
//           width: isSelected ? 45 : 38,
//           height: isSelected ? 45 : 38,
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.orange : Colors.black26,
//             shape: BoxShape.circle,
//           ),
//         ),
//         // Icon
//         Icon(
//           icon,
//           color: Colors.white,
//           size: 20,
//         ),
//         // Ripple effect
//         Positioned.fill(
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//               borderRadius: BorderRadius.circular(30),
//               splashColor: Colors.white.withOpacity(0.5),
//               highlightColor: Colors.white.withOpacity(0.2),
//               radius: 40,
//             ),
//           ),
//         ),
       
//       ],
//     ),
//   );
// }


Widget _buildNavItem(int index, IconData icon, bool isSelected) {
  return RippleAnimation(
    // size: isSelected ? 45 : 38,
    onTap: () => setState(() => _selectedIndex = index),
    child:  Material(
    color: Colors.transparent,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Background container
        Container(
          width: isSelected ? 45 : 38,
          height: isSelected ? 45 : 38,
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange : Colors.black26,
            shape: BoxShape.circle,
          ),
        ),
        // Icon
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        // // Ripple effect
        // Positioned.fill(
        //   child: Material(
        //     color: Colors.transparent,
        //     child: InkWell(
        //       onTap: () {
        //         setState(() {
        //           _selectedIndex = index;
        //         });
        //       },
        //       borderRadius: BorderRadius.circular(30),
        //       splashColor: Colors.white.withOpacity(0.5),
        //       highlightColor: Colors.white.withOpacity(0.2),
        //       radius: 40,
        //     ),
        //   ),
        // ),
       
      ],
    ),
  )
  );
}
}
