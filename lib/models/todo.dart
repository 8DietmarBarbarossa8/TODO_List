import 'package:flutter/material.dart';
import 'package:todo_list/views/recipe_card.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
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
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/todo_background.jpg'),
                fit: BoxFit.cover)),
        child: RecipeCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void _addTask() {}
}
