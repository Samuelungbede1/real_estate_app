import 'package:real_estate_app/data/local/local_property_data_ource.dart';

import '../../domain/repositories/property_repository.dart';
import '../../domain/entities/property.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final LocalPropertySource localSource;

  PropertyRepositoryImpl({required this.localSource});

  @override
  Future<List<Property>> getProperties() async {
    print('-----');
    final models = await localSource.getProperties();
     print('DATA1');
     print(models[0].description);
    return models.toList();
  }
}
