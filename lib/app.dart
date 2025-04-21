import 'package:flutter/material.dart';
import 'package:real_estate_app/core/utils/app_colors.dart';
import 'package:real_estate_app/core/utils/responsive_screen_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/config/routes.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
   Responsive.init(context); 

    return ScreenUtilInit(
      designSize: const Size(Responsive.mockupWidth, Responsive.mockupHeight),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        
        color: AppColors.white,
        debugShowCheckedModeBanner: false,
        title: 'RealEstate',
        theme: ThemeData.light(),
        themeMode: ThemeMode.light,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
