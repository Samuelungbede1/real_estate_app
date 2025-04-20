import 'package:flutter/material.dart';
import 'package:real_estate_app/app.dart';
import 'package:real_estate_app/data/local/local_property_data_ource.dart';
import 'package:real_estate_app/data/local/local_property_data_source_impl.dart';

import 'data/repositories/property_repository_impl.dart';
import 'domain/repositories/property_repository.dart';
import 'domain/uses_cases/get_properties.dart';
import 'presentation/providers/property_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    Provider<LocalPropertySource>(
      create: (_) => LocalPropertySourceImpl(),
    ),
    Provider<PropertyRepository>(
      create: (context) => PropertyRepositoryImpl(
        localSource: context.read<LocalPropertySource>(),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => PropertyProvider(
        getProperties: GetProperties(
          context.read<PropertyRepository>(),
        ),
      ),
    ),
  ], child: const App()));
}
