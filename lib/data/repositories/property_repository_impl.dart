import 'package:real_estate_app/data/local/local_property_data_ource.dart';

import '../../domain/repositories/property_repository.dart';
import '../../domain/entities/property.dart';


class PropertyRepositoryImpl implements PropertyRepository {
  final LocalPropertySource localSource;

  PropertyRepositoryImpl({required this.localSource});

  @override
  Future<List<Property>> getProperties() async {
    final models = await localSource.getProperties();
    return models.toList(); 
  }
}

