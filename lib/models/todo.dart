import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/views/todo_card.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final List<Task> tasks = [
    Task(
      taskName: "Become a superman",
      data: DateTime(2023, 1, 3),
      isStarred: true,
      isCompleted: true,
    )
  ];

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Tasks",
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/todo_background.jpg'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: tasks.map((Task task) {
              return TodoCard(
                task: task,
                completingAction: changeCompletingStatus(task),
                starAction: changeStarredStatus(task),
              );
            }).toList(),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _addTask();
        }),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void _addTask() {
    _displayDialog();
  }

  Function changeCompletingStatus(Task task) {
    return () => task.isCompleted = !task.isCompleted;
  }

  Function changeStarredStatus(Task task) {
    return () => task.isStarred = !task.isStarred;
  }

  // textFieldController.text
  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  tasks.add(Task(
                    taskName: _textFieldController.text,
                    data: DateTime.now(),
                  ));
                });
                _textFieldController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
