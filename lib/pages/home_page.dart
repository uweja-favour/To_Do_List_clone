import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/models/myTodoList.dart';
import 'package:todoist_clone/models/page_manager.dart';
import 'package:todoist_clone/pages/default_page.dart';

import '../models/myTodoPage.dart';
import '../models/todo.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController myController = TextEditingController();

   final FocusNode _focusNode = FocusNode();

  late String mmm; // Ensure mmm is non-nullable

   @override
   void initState() {
     super.initState();

     // Initialize mmm with a default value
     mmm = Provider.of<PageManager>(context, listen: false).pageNames.isNotEmpty
         ? Provider.of<PageManager>(context, listen: false).pageNames.first
         : 'Default Page';
     // Request focus when the widget is first built
     WidgetsBinding.instance.addPostFrameCallback((_) {
       _focusNode.requestFocus();
     });
     myController.addListener(() {
       setState(() {}); // Triggers rebuild
     });
   }

   @override
   void dispose() {
     _focusNode.dispose(); // Dispose of the focus node when the widget is disposed of
     myController.dispose(); // Dispose of the text controller when the widget is disposed of
     super.dispose();
   }
   void getClick(String pageName) {
     setState(() {
       mmm = pageName;
     });

     print("Value is !!! $mmm");
   }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.check_circle, color: Colors.white, size: 40),
        ),
        title: Row(
          children: [
            const Text(
              'All Lists',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),

            DropdownButton<String>(
              dropdownColor: Colors.blue[600],
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 35,
              ),
              underline: Container(),  // To remove the underline of the DropdownButton
              items: Provider.of<PageManager>(context).pageNames.map((String pageName) {
                return DropdownMenuItem<String>(
                  value: pageName,
                  child: GestureDetector(
                    onTap: () {
                      getClick(pageName);
                       mmm = pageName;
                    },
                    child: Text(
                      pageName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle page change here if needed
                if (newValue != null) {
                  setState(() {
                    mmm = newValue; // Update mmm when a new value is selected
                  });
                  print(newValue);
                }
              }
            ),
          ],
        ),
        actions: const [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.search_sharp, color: Colors.white, size: 35),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 35,
              ),
            ],
          ),
        ],
        elevation: 10,
        shadowColor: Colors.black,
      ),



      body: Column(
        children: [
          // The main content of the page
          Expanded(
            child: DefaultPage(myEditingController: myController, todoPageName: mmm ?? 'Default Page',),
            // child: MyTodoPage(myEditingController: myController),
          ),

          // The button and text field at the bottom
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.blue[100],
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue[500],
                    prefixIcon: myController.text.isEmpty || myController.text == '' ? const Icon(Icons.mic, color: Colors.white) : const SizedBox(width: 48.0),
                    hintText: 'Enter Quick Task Here',
                    hintStyle: TextStyle(color: Colors.blue[200]),
                    contentPadding: const EdgeInsets.only(top: 13),
                    focusColor: Colors.blue[200],
                    suffixIcon: myController.text.isEmpty || myController.text == '' ? null
                        : GestureDetector(
                            onTap: () {
                              print('HELLO THERE');
                              String userInput = myController.text;
                              print(userInput.toString());
                              myController.clear();
                              print('ABOUT NOW');
                              if (userInput != '' && userInput != null) {
                                print("IT'S NOT EMPTY");
                                Todo newTodo = Todo(
                                    name: userInput,
                                    date: null,
                                    time: null
                                );
                                print('ABOUT TO...');
                                print('mmm is ' + mmm);
                                var todoPage = Provider.of<PageManager>(context, listen: false).getPage(mmm);
                                todoPage?.addToDo(newTodo);
                                // myTodoList.addToDo(newTodo);
                              }
                            },
                          child: const Icon(Icons.check, color: Colors.white,)),
                  ),

                  focusNode: _focusNode,
                  cursorColor: Colors.cyanAccent,
                  showCursor: true,
                  controller: myController,
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}
