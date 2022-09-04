import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(250, 33, 33, 33),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: const [
          Icon(Icons.circle_outlined, color: Colors.grey,),
          Text("Task name"),
          Text("Task data")
        ],
      ),
    );
  }
}
