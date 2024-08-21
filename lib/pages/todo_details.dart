import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoist_clone/models/page_manager.dart';

class TodoDetails extends StatefulWidget {
  const TodoDetails({super.key});

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  final TextEditingController myController = TextEditingController();
  final TextEditingController myController2 = TextEditingController();
  final TextEditingController alertDialogController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    // myController.addListener(() {
    //   setState(() {}); // Triggers rebuild
    // });
  }

  @override
  void dispose() {
    // Dispose of any resources you are using
    _focusNode.dispose(); // Dispose of the focus node when the widget is disposed of
    myController.dispose();
    myController2.dispose();
    alertDialogController.dispose(); // Dispose of the text controller when the widget is disposed of
    super.dispose(); // Call super.dispose() last
  }

  void bringUpDialogue() {
    // Remove focus from the current TextField
    final FocusNode dialogFocusNode = FocusNode();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New List: '),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16
              ),
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.mic, color: Colors.white),
                hintText: 'Enter List Here',
                hintStyle:
                TextStyle(color: Colors.grey[400], fontSize: 22),
                contentPadding: const EdgeInsets.only(
                    bottom: 1, top: 8, left: 8, right: 8),
              ),
              focusNode: dialogFocusNode,
              cursorColor: Colors.cyanAccent,
              showCursor: true,
              controller: alertDialogController,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                      child: const Text('CANCEL', style: TextStyle(color: Colors.blue))
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      String pageName = alertDialogController.text;
                      if (pageName != null && pageName != '' && pageName.isNotEmpty) {
                        print('IF STATEMENT IS TRUE');
                        Provider.of<PageManager>(context, listen: false).createPage(pageName);
                      }
                      Navigator.pop(context);
                    },
                      child: const Text('ADD', style: TextStyle(color: Colors.blue),)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      // Dispose the dialog's FocusNode when the dialog is closed
      dialogFocusNode.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Task',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Container(
          width: screenWidth,
          color: Colors.blue[900],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'What is to be done?',
                      style: TextStyle(
                          color: Colors.blue[200],
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.mic, color: Colors.white),
                      hintText: 'Enter Task Here',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 22),
                      contentPadding: const EdgeInsets.only(
                          bottom: 1, top: 8, left: 8, right: 8),
                    ),
                    focusNode: _focusNode,
                    cursorColor: Colors.cyanAccent,
                    showCursor: true,
                    controller: myController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Due date',
                      style: TextStyle(
                          color: Colors.blue[200],
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      suffixIcon:
                          const Icon(Icons.calendar_month, color: Colors.white),
                      hintText: 'Date not set',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 22),
                      contentPadding: const EdgeInsets.only(
                          bottom: 1, top: 8, left: 8, right: 8),
                    ),
                    cursorColor: Colors.cyanAccent,
                    showCursor: true,
                    controller: myController2,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Add to List',
                      style: TextStyle(
                          color: Colors.blue[200],
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Default', style: TextStyle(color: Colors.grey[400], fontSize: 22),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.arrow_drop_down_outlined, size: 30, color: Colors.white,),
                            GestureDetector(
                              onTap: () {
                                bringUpDialogue();
                              },
                                child: const Icon(Icons.list_outlined, size: 30, color: Colors.white,))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
