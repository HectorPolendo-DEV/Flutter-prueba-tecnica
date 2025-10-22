class PhotoModel {
  final String id;
  final String small;
  final String regular;
  final String alt;
  final String author;

  const PhotoModel({
    required this.id,
    required this.small,
    required this.regular,
    required this.alt,
    required this.author,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    final urls = (json['urls'] as Map?) ?? const {};
    final user = (json['user'] as Map?) ?? const {};
    return PhotoModel(
      id: json['id'] as String,
      small: (urls['small'] ?? '') as String,
      regular: (urls['regular'] ?? '') as String,
      alt: (json['alt_description'] ?? json['description'] ?? '') as String,
      author: (user['name'] ?? user['username'] ?? '') as String,
    );
  }
}
