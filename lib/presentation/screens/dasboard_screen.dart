import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/assets.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';
import 'package:real_estate_app/presentation/widgets/address_indicator.dart';
import 'package:real_estate_app/presentation/widgets/animated_location.dart';
import 'package:real_estate_app/presentation/widgets/animated_offer_widget.dart';
import 'package:real_estate_app/presentation/widgets/animated_rent_widget.dart';
import 'package:real_estate_app/presentation/widgets/custom_icon.dart';
import 'package:real_estate_app/presentation/widgets/expanding_profile_icon.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Important
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.4, 1.0],
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFF8EAD8),
                  Color(0xFFE8D1B7),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExpandingLocationWidget(
                        location: 'Saint Petersburg',
                        animations:
                            animations, // Your DashboardAnimations instance
                      ),
                      const SizedBox(width: 8),
                      ExpandingProfileIcon(animations: animations),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Greeting
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animations.controller,
                          curve: const Interval(
                            0.15, // delay start (65% into the main animation timeline)
                            .25, // ends at 60%
                            curve: Curves.easeIn,
                          ),
                        ),
                        child: const Text(
                          'Hi, Marina',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      // // ⬇️ Add this for animated reveal
                      // AnimatedBuilder(
                      //   animation: animations.controller,
                      //   builder: (context, child) {
                      //     return ClipRect(
                      //       child: Align(
                      //         alignment: Alignment.topLeft,
                      //         heightFactor: animations.revealAnimation
                      //             .value, // Use the revealAnimation here!
                      //         child: const Text(
                      //           "Let's select your \nperfect place",
                      //           style: const TextStyle(
                      //             fontSize: 28,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.black87,
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // )

                      ClipRect(
                        child: Align(
                          alignment: Alignment.topLeft,
                          heightFactor: 1,
                          child: SlideTransition(
                            position: animations.perfectPlaceSlide,
                            child: const Text(
                              "Let's select your \nperfect place",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      // Assuming you have initialized your DashboardAnimations instance as 'animations'

                      AnimatedOfferCircle(animations: animations),

                      SizedBox(
                        width: 10,
                      ),
                      AnimatedRentWidget(animations: animations)
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // Floating White Foreground Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: animations.controller,
              builder: (context, child) {
                return DraggableScrollableSheet(
                  initialChildSize: animations.sheetSizeAnimation.value,
                  minChildSize: 0.0006,
                  maxChildSize: 0.68,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            // offset: Offset(0, -2),
                          )
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        children: [
                          // Staggered grid with colored containers

                          Column(
                            children: [
// Top full-width container

                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/icons/study.png'), // Replace with your image path

                                      fit: BoxFit
                                          .cover, // Adjust how the image should fit
                                    ),
                                  ),
                                  height: 190,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedAddressIndicator(
                                        interval: const Interval(0.55, 0.70,
                                            curve: Curves.easeInToLinear),
                                        animations: animations,
                                        address: "Gladkova St., 25",
                                        onTap: () {
// Handle tap event

                                          print("Address indicator tapped");
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

// Bottom row with vertical container on left and two stacked containers on right

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
// Left vertical container

                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/hall_way.png'), // Replace with your image path

                                            fit: BoxFit
                                                .cover, // Adjust how the image should fit
                                          ),
                                        ),
                                        height: 320,
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            AnimatedAddressIndicator(
                                              interval: const Interval(
                                                 0.70, 0.80,
                                                  curve: Curves.easeInToLinear),
                                              animations: animations,
                                              address: "2 Gladkova St., 25",
                                              onTap: () {
// Handle tap event

                                                print(
                                                    "Address indicator tapped");
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

// Right column with two stacked containers

                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
// Top right container

                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/icons/large_room.png'), // Replace with your image path

                                                fit: BoxFit
                                                    .cover, // Adjust how the image should fit
                                              ),
                                            ),
                                            height: 156,
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                AnimatedAddressIndicator(
                                                  interval: const Interval(
                                                      0.65, 0.75,
                                                      curve: Curves
                                                          .easeInToLinear),
                                                  animations: animations,
                                                  address: "3 Gladkova St., 25",
                                                  onTap: () {
// Handle tap event

                                                    print(
                                                        "Address indicator tapped");
                                                  },
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 8),

// Bottom right container

                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/icons/sofa.png'), // Replace with your image path

                                                fit: BoxFit
                                                    .cover, // Adjust how the image should fit
                                              ),
                                            ),
                                            height: 156,
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                AnimatedAddressIndicator(
                                                  interval: const Interval(
                                                        0.70, 0.80,
                                                      curve: Curves
                                                          .easeInToLinear),
                                                  animations: animations,
                                                  address: "4 Gladkova St., 25",
                                                  onTap: () {
// Handle tap event

                                                    print(
                                                        "Address indicator tapped");
                                                  },
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Your existing content here...
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

AnimatedBuilder(
  animation: animations.controller,
  builder: (context, child) {
    return Positioned(
      bottom: animations.bottomNavPosition.value,
      left: 85,
      right: 85,
      child: child!,
    );
  },
  child: Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.9),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(0, Icons.circle, true),
        _buildNavItem(1, Icons.chat_bubble_outline, false),
        _buildNavItem(2, Icons.camera_alt_outlined, false),
        _buildNavItem(3, Icons.favorite_border, false),
        _buildNavItem(4, Icons.person_outline, false),
      ],
    ),
  ),
)

          // Positioned(
          //   bottom: -100,
          //   left: 85,
          //   right: 85,
          //   child: Container(
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.9),
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         _buildNavItem(0, Icons.circle, true),
          //         _buildNavItem(1, Icons.chat_bubble_outline, false),
          //         _buildNavItem(2, Icons.camera_alt_outlined, false),
          //         _buildNavItem(3, Icons.favorite_border, false),
          //         _buildNavItem(4, Icons.person_outline, false),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  static Widget _offerCardRound(String label, String count, Color bgColor,
      {bool darkText = false}) {
    return Container(
      width: 180, // Set width and height to the same value
      height: 180,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(100), // Makes it circular
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Buy",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Text(
                '1034',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: darkText ? Colors.black87 : Colors.white,
                ),
              ),
              // const SizedBox(height: 4),
              const Text(
                "offers",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  static Widget _offerCard(String label, String count, Color bgColor,
      {bool darkText = false}) {
    return Expanded(
      child: Container(
        height: 180,
        // width: 200,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "RENT",
                style: TextStyle(
                  color: Colors.brown,
                ),
              ),
              Column(
                children: [
                  Text(
                    count,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "offers",
                    style: TextStyle(
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _selectedNavIndex = index;
        // });
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

  //Animations
  Widget _buildAnimatedLocation(DashboardAnimations animations) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.5, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animations.controller,
          curve: const Interval(0.1, 0.5, curve: Curves.easeInOut),
        ),
      ),
      child: FadeTransition(
        opacity: animations.fadeAnimation,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: [
              Icon(Icons.location_on_rounded, size: 16, color: Colors.brown),
              SizedBox(width: 8),
              Text(
                'Saint Petersburg',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
