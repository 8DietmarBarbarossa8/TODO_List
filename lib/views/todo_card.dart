// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/tools/data_time_format.dart';

class TodoCard extends StatefulWidget {
  late Task task;
  late Function completingAction, starAction;

  TodoCard(
      {Key? key,
      required this.task,
      required this.completingAction,
      required this.starAction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoCard();
}

class _TodoCard extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    Icon completeIcon = Icon(
      widget.task.isCompleted ? Icons.check : Icons.circle_outlined,
      color: Colors.grey,
      size: 28,
    );

    Icon starIcon = Icon(
      widget.task.isStarred ? Icons.star_rounded : Icons.star_outline_rounded,
      color: Colors.grey,
      size: 23,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      width: MediaQuery.of(context).size.width,
      height: 65,
      decoration: BoxDecoration(
        color: const Color.fromARGB(250, 33, 33, 33),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.completingAction();
                          });
                        },
                        icon: completeIcon,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.taskName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 8,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                DataTimeFormat.setDataFormat(widget.task.data),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.starAction();
                          });
                        },
                        icon: starIcon,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
