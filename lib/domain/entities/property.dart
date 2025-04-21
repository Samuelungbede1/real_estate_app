class Property {
  final String id;
  final String description;
  final String images;
  final Location location;

  Property({
    required this.id,
    required this.description,
    required this.images,
    required this.location,
  });

  Property copyWith({
    String? id,
    String? description,
    double? price,
    String? images,
    Location? location,
  }) {
    return Property(
      id: id ?? this.id,
      description: description ?? this.description,
      images: images ?? this.images,
      location: location ?? this.location,
    );
  }
}

class Location {
  final double latitude;
  final double longitude;
  final String address;
  final String label;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.label,
  });
}
