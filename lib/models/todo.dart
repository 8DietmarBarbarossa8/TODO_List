import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/views/todo_card.dart';

import '../database/application_database.dart';
import '../tools/data_time_format.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Task> tasks = [];
  final TextEditingController _textFieldController = TextEditingController();
  final _db = DatabaseConnect();
  int _sortMode = 0;

  @override
  void initState() {
    super.initState();
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Tasks",
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _sortList();
              },
              icon: const Icon(
                Icons.filter_alt_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                _deleteTask();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ],
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
                  _addTask(_textFieldController.text, newDT ?? DateTime.now());
                  _textFieldController.clear();
                },
              ),
            ],
          );
        });
      },
    );
  }

  void updateList() async {
    await _db.getTask().then((value) {
      setState(() => tasks = value);
    });
  }

  void _addTask(String name, DateTime dateTime) {
    setState(() {
      Task task = Task(
        taskName: name,
        data: dateTime,
      );
      _db.insertTask(task);
      updateList();
    });
  }

  void _sortList() {
    setState(() {
      _sortMode++;
      if (_sortMode == 1) {
        tasks.sort((a, b) => a.taskName.compareTo(b.taskName));
      } else if (_sortMode == 2) {
        tasks.sort((a, b) => a.data.compareTo(b.data));
        _sortMode = 0;
      }
    });
  }

  void _deleteTask() {
    setState(() {
      if (tasks.isNotEmpty) {
        _db.deleteTask(tasks[tasks.length - 1]);
      }
      updateList();
    });
  }

  Function _changeCompletingStatus(Task task) {
    return () {
      task.isCompleted = !task.isCompleted;
      _db.updateTask(task);
    };
  }

  Function _changeStarredStatus(Task task) {
    return () {
      task.isStarred = !task.isStarred;
      _db.updateTask(task);
    };
  }
}
