import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/assets.dart';
import 'package:real_estate_app/presentation/widgets/address_indicator.dart';
import 'package:real_estate_app/presentation/widgets/custom_icon.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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

          // Foreground Content (safe area + scrollable)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                            Icon(Icons.location_on_rounded,
                                size: 16, color: Colors.brown),
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
                      const SizedBox(width: 8),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape
                              .circle, // This ensures the container is circular
                        ),
                        child: const ClipOval(
                          child: CustomIcon(
                            fit: BoxFit.fill,
                            showImage: true,
                            Assets.profileImage,
                            size:
                                50, // Set size equal to container size for a perfect circle
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Greeting
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Marina,",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Let's select your \nperfect place",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Row(
                    children: [
                      _offerCardRound("BUY", "034", Colors.deepOrange),
                      const SizedBox(width: 16),
                      _offerCard("RENT", "2,212", Colors.white, darkText: true),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Floating White Foreground Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.3, // 30% of screen height
              minChildSize: 0.101,
              maxChildSize: 0.71,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AnimatedAddressIndicator(
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
                              ),
                              const SizedBox(width: 8),
                              // Right column with two stacked containers
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    // Top right container
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
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
                                              address: "Gladkova St., 25",
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
                                      borderRadius: BorderRadius.circular(24),
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
                                              address: "Gladkova St., 25",
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
                    ],
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: 30,
            left: 85,
            right: 85,
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
          ),
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
}
