

import 'package:real_estate_app/data/local/local_property_data.dart';
import '../model/property_model.dart';
import 'local_property_data_ource.dart';

class LocalPropertySourceImpl implements LocalPropertySource {
  @override
  Future<List<PropertyModel>> getProperties() async {
     print('-----1');
    return mockProperties.map((json) => PropertyModel.fromJson(json)).toList();
  }
}