class ImageDescription {
  final String description;

  ImageDescription({required this.description});

  factory ImageDescription.fromJson(Map<String, dynamic> json) {
    return ImageDescription(description: json['description'] ?? 'Sin descripción');
  }
}
