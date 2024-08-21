import 'package:flutter/cupertino.dart';
import 'package:todoist_clone/models/todo_page.dart';

class PageManager extends ChangeNotifier {
  // Declare pages as final so that they are initialized once
  final TodoPage page1;
  final TodoPage page2;


  // Initialize pages in the constructor
  PageManager() : page1 = TodoPage('Default Page'), page2 = TodoPage('Your own') {
    _pages = {
      'My own': page1,
      'Your own': page2,
    };
  }

  late final Map<String, TodoPage> _pages;

  List<String> get pageNames => _pages.keys.toList();

  TodoPage createPage(String pageName) {
    final page = TodoPage(pageName);
    _pages[pageName] = page;
    print('PAGE MANAGER HERE!');
    notifyListeners();
    return page;
  }

  TodoPage? getPage(String pageName) {
    return _pages[pageName];
  }

  void removePage(String pageName) {
    _pages.remove(pageName);
    notifyListeners();
  }
}
