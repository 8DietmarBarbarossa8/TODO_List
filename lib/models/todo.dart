import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/views/todo_card.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final List<TodoCard> _cards = [
    TodoCard(
        task: Task(
          taskName: "Go outside",
          data: DateTime(2022, 9, 3),
          isStarred: false,
          isCompleted: false,
        )),
    TodoCard(
        task: Task(
          taskName: "Feed cat",
          data: DateTime(2022, 9, 4),
          isStarred: false,
          isCompleted: false,
        )),
    TodoCard(
        task: Task(
          taskName: "Create app",
          data: DateTime(2022, 9, 5),
          isStarred: false,
          isCompleted: true,
        )),
    TodoCard(
        task: Task(
          taskName: "Be cool",
          data: DateTime(2022, 10, 26),
          isStarred: true,
          isCompleted: false,
        )),
    TodoCard(
        task: Task(
          taskName: "Become a superman",
          data: DateTime(2023, 1, 3),
          isStarred: true,
          isCompleted: true,
        )),
  ];

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
            children: [for (var c in _cards) c],
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
    _cards.add(TodoCard(task: Task(
      taskName: "Create tasks like Dietrich Alex",
      data: DateTime(2022, 9, 5),
      isStarred: false,
      isCompleted: false,
    )));
  }
}
