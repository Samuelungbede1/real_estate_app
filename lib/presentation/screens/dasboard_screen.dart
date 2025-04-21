import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/core/utils/app_text.dart';
import 'package:real_estate_app/core/utils/dashboard_animation.dart';
import 'package:real_estate_app/presentation/providers/property_provider.dart';
import 'package:real_estate_app/presentation/widgets/address_indicator.dart';
import 'package:real_estate_app/presentation/widgets/animated_location.dart';
import 'package:real_estate_app/presentation/widgets/animated_offer_widget.dart';
import 'package:real_estate_app/presentation/widgets/animated_rent_widget.dart';
import 'package:real_estate_app/presentation/widgets/expanding_profile_icon.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/responsive_screen_functions.dart';

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
    Responsive.init(context);
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
              padding: EdgeInsets.all(Responsive.width(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExpandingLocationWidget(
                        location: 'Saint Petersburg',
                        animations: animations,
                      ),
                      SizedBox(width: Responsive.width(8)),
                      ExpandingProfileIcon(animations: animations),
                    ],
                  ),
                  SizedBox(height: Responsive.width(20)),
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
                        child: 
                        AppText.medium("Hi, Marina",
                                fontSize: Responsive.fontSize(24), color: AppColors.grey400),
                      
                      ),
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topLeft,
                          heightFactor: 1,
                          child: SlideTransition(
                            position: animations.perfectPlaceSlide,
                            child: 
                              AppText.medium("let's select your \nperfect place",
                                fontSize: Responsive.fontSize(30), color: AppColors.background),
                            
                        
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: Responsive.height(20)),
                  Row(
                    children: [
                      AnimatedOfferCircle(animations: animations),
                      SizedBox(
                        width: Responsive.width(10),
                      ),
                      AnimatedRentWidget(animations: animations)
                    ],
                  ),
                  SizedBox(height: Responsive.height(10)),
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
                  initialChildSize:
                      Responsive.height(animations.sheetSizeAnimation.value)*0.95,
                  minChildSize: Responsive.height(
                      animations.sheetSizeAnimation.value * 0.62),
                  maxChildSize: Responsive.height(0.65),
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    if (propertyProvider.isLoading) {
                      return Container(
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Responsive.radius(32)),
                            topRight: Radius.circular(Responsive.radius(32)),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: Responsive.radius(10),
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
                      padding:  EdgeInsets.all(Responsive.width(8)),
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Responsive.radius(32)),
                          topRight: Radius.circular(Responsive.radius(32)),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: Responsive.radius(10),
                          )
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: false,
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        children: [
                          Column(
                            children: [
                              if (propertyProvider.properties.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(Responsive.radius(24)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(propertyProvider
                                            .properties[0].images),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: Responsive.height(240),
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
                                         SizedBox(height: Responsive.height(10)),
                                      ],
                                    ),
                                  ),
                                ),
                               SizedBox(height: Responsive.height(8)),
                              if (propertyProvider.properties.length > 1)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                          height: Responsive.height(400),
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
                                               SizedBox(height:Responsive.height(10)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                     SizedBox(width: Responsive.width(8)),
                                    if (propertyProvider.properties.length > 2)
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(Responsive.radius(24)),
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
                                                height: Responsive.height(196),
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
                                                     SizedBox(height: Responsive.height(12)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                             SizedBox(height: Responsive.height(8)),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(Responsive.radius(24)),
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
                                                height: Responsive.height(196),
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
                                                     SizedBox(height: Responsive.height(10)),
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



}
