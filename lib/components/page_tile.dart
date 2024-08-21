import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/models/page_manager.dart';
import 'package:todoist_clone/models/todo_page.dart';

import '../models/todo.dart';

class PageTile extends StatefulWidget {
  Todo todo;
  PageTile({super.key, required this.todo});

  @override
  State<PageTile> createState() => _PageTileState();
}

class _PageTileState extends State<PageTile> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/todo_details');
        },
        child: Card(
          color: Colors.blue[600],
          child: ListTile(
            leading: Checkbox(
                hoverColor: Colors.white,
                activeColor: Colors.blue[100], // Color of the checkbox when checked
                checkColor: Colors.blue[900],
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _isChecked = value;
                      if (_isChecked) {
                        // removeToDoItem();
                      }
                    }
                  });
                }

            ),
            title: Text(widget.todo.name, style: const TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );;
  }
}
