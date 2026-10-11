class Exercise {
  final int id;
  final String name;
  final String category;
  final List<String> equipment;
  final String? imageUrl;

  Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.equipment,
    required this.imageUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    final categoryBox = json['category'] as Map<String, dynamic>;
    final categoryName = categoryBox['name'] as String;

    final equipmentList = (json['equipment'] as List<dynamic>)
        .map((e) => e['name'] as String)
        .toList();
    final images = json['images'] as List<dynamic>;
    final imageUrl = images.isEmpty ? null : images.first['image'] as String;
    final translations = json['translations'] as List<dynamic>;
    final english = translations.where((t) => t['language'] == 2);
    final name = english.isEmpty
        ? 'Unnamed exercise'
        : english.first['name'] as String;

    return Exercise(
      id: json['id'] as int,
      name: name,
      category: categoryName,
      equipment: equipmentList,
      imageUrl: imageUrl,
    );
  }
}
