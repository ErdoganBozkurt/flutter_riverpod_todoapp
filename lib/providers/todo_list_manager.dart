import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodo]) : super(initialTodo ?? []);

  void addTodoItem(String task) {
    Todo newTodo = Todo(
      id: const Uuid().v4(),
      task: task,
    );
    state = [...state, newTodo];
  }

  void removeTodoItem(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodoItem(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            task: todo.task,
            isDone: !todo.isDone,
          )
        else
          todo
    ];
  }

  void updateTodoItem(String id, String task) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            task: task,
            isDone: todo.isDone,
          )
        else
          todo
    ];
  }

  void setSelectedTodoItem(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            task: todo.task,
            isDone: todo.isDone,
          )
        else
          todo
    ];
  }

  String? getTask(String? id) {
    if (id == null) {
      return null;
    }
    return state.firstWhere((todo) => todo.id == id).task;
  }
}




