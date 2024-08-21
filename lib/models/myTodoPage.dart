import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/components/page_tile.dart';
import 'package:todoist_clone/models/myTodoList.dart';
import 'package:todoist_clone/models/page_manager.dart';

import '../models/todo.dart';
import '../models/todo_page.dart';

class MyTodoPage extends StatelessWidget {
  TextEditingController myEditingController;
  MyTodoPage({super.key, required this.myEditingController});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // final page = Provider.of<myTodoList>(context).getPage(todoPage.pageName);
    return Consumer<myTodoList>(
      builder: (context, value, child) {
        return (value.getTodos().isEmpty
            ? Container(
                color: Colors.blue[900],
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'List Default is empty',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blue[100]),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12)),
                            onPressed: () {},
                            child: const Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            // IF DEFAULT PAGE TODO_LIST IS NOT EMPTY THEN DISPLAY ->
            : Container(
                color: Colors.blue[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: value.getTodos().length,
                          itemBuilder: (context, index) {
                            Todo? todo = value.getTodos()[index];
                            return PageTile(todo: todo);
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(12),
                            ),
                            onPressed: () {},
                            child: const Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
      },
    );
  }
}
