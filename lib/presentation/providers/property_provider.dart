import 'package:flutter/foundation.dart';
import '../../domain/entities/property.dart';
import '../../domain/uses_cases/get_properties.dart';

class PropertyProvider with ChangeNotifier {
  final GetProperties getProperties;

  PropertyProvider({required this.getProperties});

  List<Property> _properties = [];
  List<Property> get properties => _properties;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;
  bool get hasError => _error.isNotEmpty;

  Future<void> fetchProperties() async {
    print('HEHEHEHEHEHE');
    _isLoading = true;
    notifyListeners();

    try {
      _properties = await getProperties();
      _error = '';
    } catch (e) {
      _error = e.toString();
      _properties = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
