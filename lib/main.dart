import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_app/app.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  // setupDependencyInjector();
  // registerApiInstance();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
