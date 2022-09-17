
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/todo.dart';

abstract class LocalStorage {
  // local storage methods contains Todo Object
  Future<void> addTodoItem(Todo todo);
  Future<List<Todo>> getAllTodoItems();
  Future<Todo> getTodoItem(String id);
  Future<void> updateTodoItem(Todo todo);
}

class HiveLocalStorage implements LocalStorage {
  // Add Todo Item to Local Storage as Todo Object
  @override
  Future<void> addTodoItem(Todo todo) async {
    final todoBox = await Hive.openBox<Todo>('todoBox');
    todoBox.add(todo);
  }

  // Get All Todo Items from Local Storage as List of Todo Objects
  @override
  Future<List<Todo>> getAllTodoItems() async {
    final todoBox = await Hive.openBox<Todo>('todoBox');
    return todoBox.values.toList();
  }

  // Get Todo Item from Local Storage as Todo Object
  @override
  Future<Todo> getTodoItem(String id) async {
    final todoBox = await Hive.openBox<Todo>('todoBox');
    return todoBox.get(id)!;
  }

  // Update Todo Item in Local Storage as Todo Object
  @override
  Future<void> updateTodoItem(Todo todo) async {
    final todoBox = await Hive.openBox<Todo>('todoBox');
    todoBox.put(todo.id, todo);
  }

  // Delete Todo Item from Local Storage as Todo Object
  Future<void> deleteTodoItem(String id) async {
    final todoBox = await Hive.openBox<Todo>('todoBox');
    todoBox.delete(id);
  }
}