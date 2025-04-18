import 'package:flutter/widgets.dart';
import 'package:real_estate_app/core/error/error_page.dart';
import 'package:real_estate_app/core/utils/config/navigation_builder.dart';
import 'package:real_estate_app/presentation/screens/dasboard_screen.dart';
import 'package:real_estate_app/presentation/screens/map_screen.dart';



class AppRoutes {
  AppRoutes();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return NavigationBuilder( const DashboardScreen(), settings: settings);
        // return NavigationBuilder( const MapScreen(), settings: settings);
    
      default:
        return NavigationBuilder(const ErrorPage(), settings: settings);
    }
  }

  static const String splashScreen = '/splashScreen';

}
