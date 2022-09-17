

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList(
    [
      Todo(
        id: const Uuid().v4(),
        task: 'Buy milk',
        isDone: true,
      ),
      Todo(
        id: const Uuid().v4(),
        task: 'Buy eggs',
        isDone: false,
      ),
      Todo(
        id: const Uuid().v4(),
        task: 'Buy bread',
        isDone: false,
      ),
    ],
  );
});
