
class Property {
  final String id;
  final String title;
  final String description;
  final double price;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final List<String> images;
  final Location location;
  final bool isFavorite;
  final DateTime postedDate;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.images,
    required this.location,
    this.isFavorite = false,
    required this.postedDate,
  });

  Property copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    int? bedrooms,
    int? bathrooms,
    double? area,
    List<String>? images,
    Location? location,
    bool? isFavorite,
    DateTime? postedDate,
  }) {
    return Property(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      area: area ?? this.area,
      images: images ?? this.images,
      location: location ?? this.location,
      isFavorite: isFavorite ?? this.isFavorite,
      postedDate: postedDate ?? this.postedDate,
    );
  }
}

class Location {
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}