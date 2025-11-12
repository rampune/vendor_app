// model/AboutUsModel.dart
class AboutUsModel {
  final int id;
  final String title;
  final String description;
  final String createdAt;

  AboutUsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt,
    };
  }
}