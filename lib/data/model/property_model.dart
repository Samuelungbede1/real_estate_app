import '../../domain/entities/property.dart';

class PropertyModel extends Property {
  PropertyModel({
    required String id,
    required String description,
    required String images,
    required Location location,
  }) : super(
          id: id,
          description: description,
          images: images,
          location: location,
        );

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      description: json['description'],
      images: json['images'],
      location: Location(
        latitude: json['location']['latitude'].toDouble(),
        longitude: json['location']['longitude'].toDouble(),
        address: json['location']['address'],
        label: json['location']['label'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'images': images,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'address': location.address,
        'label': location.label,
      },
    };
  }
}