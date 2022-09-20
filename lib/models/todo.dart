import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String task;

  @HiveField(2)
  final bool isDone;

  Todo({
    required this.id,
    required this.task,
    this.isDone = false,
  });

  Todo copyWith({
    String? id,
    String? task,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, task: $task, isDone: $isDone)';
  }
}
