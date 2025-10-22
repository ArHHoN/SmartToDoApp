// lib/models/task_label.dart

class TaskLabel {
  final int? taskLabelId; // Primary key
  final int labelId;
  final int taskId;

  TaskLabel({
    this.taskLabelId,
    required this.labelId,
    required this.taskId,
  });

  // ✅ Convert TaskLabel to Map (for SQLite / JSON)
  Map<String, dynamic> toMap() {
    return {
      'task_label_id': taskLabelId,
      'label_id': labelId,
      'task_id': taskId,
    };
  }

  // ✅ Create TaskLabel from Map (for SQLite / JSON)
  factory TaskLabel.fromMap(Map<String, dynamic> map) {
    return TaskLabel(
      taskLabelId: map['task_label_id'] as int?,
      labelId: map['label_id'] as int,
      taskId: map['task_id'] as int,
    );
  }

  @override
  String toString() =>
      'TaskLabel(taskLabelId: $taskLabelId, labelId: $labelId, taskId: $taskId)';
}
