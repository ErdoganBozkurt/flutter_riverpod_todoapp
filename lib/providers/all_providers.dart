import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_list_manager.dart';


final hiveProvider = FutureProvider<List<Todo>>(((ref) async {
  await Hive.initFlutter();
  final box = await Hive.openBox<Todo>('todo_box');
  return box.values.toList();
}));

final todoListProvider = StateNotifierProvider<TodoListManager, List<Todo>>((ref) {
  List<Todo> state = ref.watch(hiveProvider).value ?? [];
  return TodoListManager(state);
});

// get current todos task




