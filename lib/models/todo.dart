import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/views/todo_card.dart';

import '../tools/data_time_format.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final List<Task> tasks = [];
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
                completingAction: _changeCompletingStatus(task),
                starAction: _changeStarredStatus(task),
              );
            }).toList(),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  Future<void> _displayDialog() {
    DateTime initDT = DateTime.now();
    DateTime? newDT;
    String data = "";

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add a new todo item'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Type your new todo'),
            ),
            actions: <Widget>[
              Text(data),
              IconButton(
                  onPressed: () async {
                    DateTime? dt = await showDatePicker(
                        context: context,
                        initialDate: newDT == null ? initDT : newDT!,
                        firstDate: initDT,
                        lastDate: DateTime(2100));

                    if (dt == null) {
                      newDT = null;
                      return;
                    } else {
                      setState(() {
                        newDT = dt;
                        data = DataTimeFormat.setDataFormat(newDT);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today_sharp)),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTask(_textFieldController.text, newDT);
                  _textFieldController.clear();
                },
              ),
            ],
          );
        });
      },
    );
  }

  void _addTask(String name, DateTime? dateTime) {
    setState(() {
      tasks.add(Task(
        taskName: name,
        data: dateTime,
      ));
    });
  }

  Function _changeCompletingStatus(Task task) {
    return () => task.isCompleted = !task.isCompleted;
  }

  Function _changeStarredStatus(Task task) {
    return () => task.isStarred = !task.isStarred;
  }
}
