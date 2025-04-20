import '../model/property_model.dart';


abstract class LocalPropertySource {
  Future<List<PropertyModel>> getProperties();
}

