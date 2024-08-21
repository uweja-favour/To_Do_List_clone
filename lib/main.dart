import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/models/myTodoList.dart';
import 'package:todoist_clone/models/page_manager.dart';
// import 'package:todoist_clone/models/default_page_todo_list.dart';
import 'package:todoist_clone/pages/home_page.dart';
import 'package:todoist_clone/pages/todo_details.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => myTodoList()), ChangeNotifierProvider(create: (context) => PageManager())],
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          routes: {
            '/todo_details': (context) => const TodoDetails(),
          },
        ),
      );
  }
}
