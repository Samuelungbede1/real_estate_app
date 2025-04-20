import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';
import 'package:real_estate_app/presentation/providers/property_provider.dart';
import 'package:real_estate_app/presentation/widgets/address_indicator.dart';
import 'package:real_estate_app/presentation/widgets/animated_location.dart';
import 'package:real_estate_app/presentation/widgets/animated_offer_widget.dart';
import 'package:real_estate_app/presentation/widgets/animated_rent_widget.dart';
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
    animations = DashboardAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyProvider>().fetchProperties();
    });
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animations.controller,
                          curve: const Interval(
                            0.15,
                            .25,
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
                      AnimatedOfferCircle(animations: animations),
                      const SizedBox(
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
                    if (propertyProvider.isLoading) {
                      return Container(
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
                            )
                          ],
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (propertyProvider.hasError) {
                      return Container(
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
                            )
                          ],
                        ),
                        child: Center(
                            child: Text('Error: ${propertyProvider.error}')),
                      );
                    }

                    if (propertyProvider.properties.isEmpty) {
                      return Container(
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
                            )
                          ],
                        ),
                        child: const Center(
                            child: Text('No properties available')),
                      );
                    }
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
                          )
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        children: [
                          Column(
                            children: [
                              if (propertyProvider.properties.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(propertyProvider
                                            .properties[0].images),
                                        fit: BoxFit.cover,
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
                                          address: propertyProvider
                                              .properties[0].location.address,
                                          onTap: () {},
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 8),

                              // Secondary properties row
                              if (propertyProvider.properties.length > 1)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left property
                                    Expanded(
                                      flex: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(propertyProvider
                                                  .properties[1].images),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 320,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              if (propertyProvider
                                                      .properties.length >
                                                  1)
                                                AnimatedAddressIndicator(
                                                  interval: const Interval(
                                                      0.70, 0.80,
                                                      curve: Curves
                                                          .easeInToLinear),
                                                  animations: animations,
                                                  address: propertyProvider
                                                      .properties[1]
                                                      .location
                                                      .address,
                                                  onTap: () {},
                                                ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    // Right properties column
                                    if (propertyProvider.properties.length > 2)
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        propertyProvider
                                                            .properties[2]
                                                            .images),
                                                    fit: BoxFit.cover,
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
                                                      address: propertyProvider
                                                          .properties[2]
                                                          .location
                                                          .address,
                                                      onTap: () {},
                                                    ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        propertyProvider
                                                            .properties[3]
                                                            .images),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                height: 156,
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (propertyProvider
                                                            .properties.length >
                                                        3)
                                                      AnimatedAddressIndicator(
                                                        interval: const Interval(
                                                            0.70, 0.80,
                                                            curve: Curves
                                                                .easeInToLinear),
                                                        animations: animations,
                                                        address:
                                                            propertyProvider
                                                                .properties[3]
                                                                .location
                                                                .address,
                                                        onTap: () {},
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
                );
              },
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
