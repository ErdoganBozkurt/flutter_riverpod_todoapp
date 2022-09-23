import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:todo_app/models/todo.dart';

import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<Todo>> {
  TodoListManager(List<Todo> state) : super(state);

  void addTodoItem(String task) async {
    var box = await Hive.openBox<Todo>('todo_box');
    box.add(Todo(
      id: const Uuid().v1(),
      task: task,
      isDone: false,
    ));

    state = box.values.toList();
  }

  Future deleteTodoItem(String id) async {
    var box = await Hive.openBox<Todo>('todo_box');
    await box.deleteAt(
        box.values.toList().indexWhere((element) => element.id == id));

    state = box.values.toList();
  }

  void editTodoItem(Todo todo) async {
    var box = await Hive.openBox<Todo>('todo_box');

    await box.putAt(
      box.values.toList().indexWhere((element) => element.id == todo.id),
      todo,
    );

    state = box.values.toList();
  }

  void toggleTodoItem(Todo todo) async {
    var box = await Hive.openBox<Todo>('todo_box');
    await box.putAt(
      box.values.toList().indexWhere((element) => element.id == todo.id),
      todo.copyWith(isDone: !todo.isDone),
    );

    state = box.values.toList();
  }

  void deleteAllTodoItem() async {
    var box = await Hive.openBox<Todo>('todo_box');
    await box.clear();

    state = box.values.toList();
  }

  // delete todo item temporarily from the list
  void deleteTodoItemTemporarily(String id) {
    state = state.where((element) => element.id != id).toList();
  }

  // restore todo item from the list
  void restoreTodoItem(Todo todo) {
    state = [...state, todo];
  }
  
 
}
