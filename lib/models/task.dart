// lib/models/task.dart

class Task {
  final int? id; // Primary key
  final String name;
  final int? categoryId; // Foreign key to Category
  final String? time; // e.g. "09:00 AM"
  final DateTime createdAt;
  final String? description;
  String status; // e.g. "pending", "completed"
  final int priority; // e.g. 1 = low, 2 = medium, 3 = high

  Task({
    this.id,
    required this.name,
    this.categoryId,
    this.time,
    required this.createdAt,
    this.description,
    this.status = "pending",
    this.priority = 1,
  });

  // ✅ Convert Task to Map (for SQLite / JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'time': time,
      'created_at': createdAt.toIso8601String(),
      'description': description,
      'status': status,
      'priority': priority,
    };
  }

  // ✅ Create Task from Map (for SQLite / JSON)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      name: map['name'] as String,
      categoryId: map['category_id'] as int?,
      time: map['time'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      description: map['description'] as String?,
      status: map['status'] as String? ?? "pending",
      priority: map['priority'] as int? ?? 1,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name, categoryId: $categoryId, time: $time, createdAt: $createdAt, '
        'description: $description, status: $status, priority: $priority)';
  }
}
