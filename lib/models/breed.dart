// lib/models/breed.dart
class Breed {
  final String id;
  final String name;
  final String origin;
  final String temperament;
  final String description;
  final int intelligence;
  final String referenceImageId;

  Breed({
    required this.id,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.description,
    required this.intelligence,
    required this.referenceImageId,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      temperament: json['temperament'],
      description: json['description'],
      intelligence: json['intelligence'],
      referenceImageId: json['reference_image_id'] ?? '',
    );
  }
}
