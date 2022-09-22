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

final dayTimeNameProvider = Provider<String>((ref) {
  final hour = DateTime.now().hour;
  if (hour < 12 && hour >= 5) {
    return 'Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Afternoon';
  } else if (hour >= 17 && hour < 23) {
    return 'Evening';
  } else {
    return 'Night';
  }
});




