import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/components/page_tile.dart';
import 'package:todoist_clone/models/page_manager.dart';
import '../models/todo.dart';
import '../models/todo_page.dart';

class DefaultPage extends StatelessWidget {
  final TextEditingController myEditingController;
  final String todoPageName;

  const DefaultPage({Key? key, required this.myEditingController, required this.todoPageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final page = Provider.of<PageManager>(context).getPage(todoPageName);

    // Check if the page is null or the list of todos is empty
    bool isPageEmpty = page == null || page.getTodos().isEmpty;

    return Container(
      color: Colors.blue[900],
      child: Column(
        children: [
          Expanded(
            child: isPageEmpty
                ? Center(
                  child: Text(
                'List $todoPageName is empty', style: TextStyle(fontSize: 20, color: Colors.blue[100]),),
                )
                : ListView.builder(
                  itemCount: page.getTodos().length,
                  itemBuilder: (context, index) {
                    Todo? todo = page.getTodos()[index];
                    return todo != null ? PageTile(todo: todo) : const SizedBox.shrink();
                  },
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
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/todo_details');
                  },
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
    );
  }
}
