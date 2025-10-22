// lib/models/category.dart

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // ✅ Convert Category to Map (for SQLite / JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // ✅ Create Category from Map (for SQLite / JSON)
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  @override
  String toString() => 'Category(id: $id, name: $name)';
}
