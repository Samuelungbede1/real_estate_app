import '../repositories/property_repository.dart';
import '../entities/property.dart';

class GetProperties {
  final PropertyRepository repository;
 

  GetProperties(this.repository);

  Future<List<Property>> call() async {
 print('Hey you');
    return await repository.getProperties();
  }
}