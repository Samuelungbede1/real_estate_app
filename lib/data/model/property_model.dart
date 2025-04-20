import '../../domain/entities/property.dart';

class PropertyModel extends Property {
  PropertyModel({
    required String id,
    required String title,
    required String description,
    required double price,
    required int bedrooms,
    required int bathrooms,
    required double area,
    required List<String> images,
    required Location location,
    required bool isFavorite,
    required DateTime postedDate,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          bedrooms: bedrooms,
          bathrooms: bathrooms,
          area: area,
          images: images,
          location: location,
          isFavorite: isFavorite,
          postedDate: postedDate,
        );

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      area: json['area'].toDouble(),
      images: List<String>.from(json['images']),
      location: Location(
        latitude: json['location']['latitude'].toDouble(),
        longitude: json['location']['longitude'].toDouble(),
        address: json['location']['address'],
      ),
      isFavorite: json['isFavorite'] ?? false,
      postedDate: DateTime.parse(json['postedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'images': images,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'address': location.address,
      },
      'isFavorite': isFavorite,
      'postedDate': postedDate.toIso8601String(),
    };
  }
}