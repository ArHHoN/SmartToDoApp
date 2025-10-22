// lib/models/label.dart

class Label {
  final int? id; // Primary key
  final String name;
  final String color; // Store as hex string like "#FFA726"

  Label({
    this.id,
    required this.name,
    required this.color,
  });

  // ✅ Convert Label to Map (for SQLite / JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }

  // ✅ Create Label from Map (for SQLite / JSON)
  factory Label.fromMap(Map<String, dynamic> map) {
    return Label(
      id: map['id'] as int?,
      name: map['name'] as String,
      color: map['color'] as String,
    );
  }

  @override
  String toString() => 'Label(id: $id, name: $name, color: $color)';
}
