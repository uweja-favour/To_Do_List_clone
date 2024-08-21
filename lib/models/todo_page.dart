import 'package:flutter/cupertino.dart';
import 'package:todoist_clone/models/todo.dart';

class TodoPage extends ChangeNotifier {

  String pageName;
  List<Todo> todos = [];

  TodoPage(this.pageName);

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