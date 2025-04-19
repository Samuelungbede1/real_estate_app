import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/app_colors.dart';
import 'package:real_estate_app/core/utils/constants/constants.dart';
import 'package:real_estate_app/core/utils/responsive_screen_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/config/routes.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
   

    return ScreenUtilInit(
      designSize: const Size(MockupWidth, MockupHeight),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        /**
         * Whenever the app is in use the timeout gets refreshed
         * */
        onTapDown: (TapDownDetails e) {
          // print("Tapped Down");
          // controller.startTimer();
        },
        // onPanEnd: (DragEndDetails e) => controller.startTimer(),
        // onTap: controller.closeKeyBoard,
        child: MaterialApp(
          
          color: AppColors.white,
          debugShowCheckedModeBanner: false,
          // fallbackLocale:
          //     const Locale(AppConstants.languageCode, AppConstants.countryCode),
          title: 'RealEstate',
          theme: ThemeData.light(),
          themeMode: ThemeMode.light,
          initialRoute: AppRoutes.splashScreen,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          // enableLog: true,
          // defaultTransition: Transition.fadeIn,
          // opaqueRoute: Get.isOpaqueRouteDefault,
          // popGesture: Get.isPopGestureEnable,
          // smartManagement: SmartManagement.full,
          
        ),
      ),
    );
  }
}
