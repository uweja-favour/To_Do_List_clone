import 'package:flutter/material.dart';
import 'package:todoist_clone/models/todo.dart';

class myTodoList extends ChangeNotifier {

  // String name;
  List<Todo> todos = [];

  // myTodoList({required this.name});


  void addToDo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  void removeToDo(Todo todo) {
    todos.remove(todo);
    notifyListeners();
  }

  List<Todo> getTodos() {
    return todos;
  }


}