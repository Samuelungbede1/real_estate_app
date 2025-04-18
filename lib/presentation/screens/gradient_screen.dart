// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:real_estate_app/presentation/providers/real_estate_provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final provider = Provider.of<RealEstateProvider>(context, listen: false);
    
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Location and profile
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildLocationPill(),
//                 _buildProfileAvatar(),
//               ],
//             ),
            
//             const SizedBox(height: 30),
            
//             // Greeting text with animation
//             TweenAnimationBuilder<double>(
//               tween: Tween<double>(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 800),
//               curve: Curves.easeOutCubic,
//               builder: (context, value, child) {
//                 return Opacity(
//                   opacity: value,
//                   child: Transform.translate(
//                     offset: Offset(0, 20 * (1 - value)),
//                     child: child,
//                   ),
//                 );
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hi, Marina',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'let\'s select your\nperfect place',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       height: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             const SizedBox(height: 30),
            
//             // Buy/Rent options with animation
//             TweenAnimationBuilder<double>(
//               tween: Tween<double>(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 1000),
//               curve: Curves.easeOutCubic,
//               builder: (context, value, child) {
//                 return Opacity(
//                   opacity: value,
//                   child: Transform.translate(
//                     offset: Offset(0, 30 * (1 - value)),
//                     child: child,
//                   ),
//                 );
//               },
//               child: Row(
//                 children: [
//                   _buildBuyOption(),
//                   const SizedBox(width: 16),
//                   _buildRentOption(),
//                 ],
//               ),
//             ),
            
//             const SizedBox(height: 30),
            
//             // Featured properties with animation
//             Expanded(
//               child: TweenAnimationBuilder<double>(
//                 tween: Tween<double>(begin: 0.0, end: 1.0),
//                 duration: const Duration(milliseconds: 1200),
//                 curve: Curves.easeOutCubic,
//                 builder: (context, value, child) {
//                   return Opacity(
//                     opacity: value,
//                     child: Transform.translate(
//                       offset: Offset(0, 40 * (1 - value)),
//                       child: child,
//                     ),
//                   );
//                 },
//                 child: Column(
//                   children: [
//                     _buildFeaturedProperty(
//                       context,
//                       'Gladkova St., 25',
//                       'assets/images/property1.jpg',
//                       () => provider.navigateToDetail(1),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildSmallProperty(
//                             context,
//                             'assets/images/property2.jpg',
//                             () => provider.navigateToDetail(2),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _buildSmallProperty(
//                             context,
//                             'assets/images/property3.jpg',
//                             () => provider.navigateToDetail(3),
//                             showAddress: true,
//                             address: 'Sokolova St., 43',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLocationPill() {
//     return Container(
//       height: 45,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: const Row(
//         children: [
//           Icon(
//             Icons.location_on_rounded,
//             size: 16,
//             color: Colors.brown,
//           ),
//           SizedBox(width: 8),
//           Text(
//             'Saint Petersburg',
//             style: TextStyle(
//               color: Colors.brown,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileAvatar() {
//     return Container(
//       height: 45,
//       width: 45,
//       decoration: BoxDecoration(
//         color: Colors.orange,
//         borderRadius: BorderRadius.circular(50),
//         image: const DecorationImage(
//           image: AssetImage('assets/images/avatar.jpg'),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildBuyOption() {
//     return Container(
//       width: 160,
//       height: 160,
//       decoration: BoxDecoration(
//         color: Colors.orange,
//         borderRadius: BorderRadius.circular(100),
//       ),
//       child: const Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "BUY",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             '1034',
//             style: TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           Text(
//             "offers",
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRentOption() {
//     return Expanded(
//       child: Container(
//         height: 160,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "RENT",
//               style: TextStyle(
//                 color: Colors.brown,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '2212',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.brown,
//               ),
//             ),
//             Text(
//               "offers",
//               style: TextStyle(
//                 color: Colors.brown,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeaturedProperty(BuildContext context, String address, String imagePath, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Hero(
//         tag: 'property-featured',
//         child: Container(
//           height: 180,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           alignment: Alignment.bottomLeft,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.6),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(24),
//                 bottomRight: Radius.circular(24),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   address,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Container(
//                   width: 30,
//                   height: 30,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 14,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSmallProperty(BuildContext context, String imagePath, VoidCallback onTap, {bool showAddress = false, String address = ''}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 120,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//           image: DecorationImage(
//             image: AssetImage(imagePath),
//             fit: BoxFit.cover,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         alignment: Alignment.bottomCenter,
//         child: showAddress
//             ? Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.6),
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(24),
//                     bottomRight: Radius.circular(24),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         address,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 12,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Container(
//                       width: 20,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 10,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : const SizedBox(),
//       ),
//     );
//   }
// }
// // 