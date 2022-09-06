// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

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
                                _setDataFormat(),
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

  String _setDataFormat() {
    DateTime dateTime = widget.task.data;
    DateTime currentDT = DateTime.now();

    bool yearEquals = dateTime.year == currentDT.year;
    bool monthEquals = dateTime.month == currentDT.month;

    if (yearEquals && monthEquals && dateTime.day == currentDT.day - 1) {
      return "Yesterday";
    } else if (yearEquals && monthEquals && dateTime.day == currentDT.day) {
      return "Today";
    } else if (yearEquals && monthEquals && dateTime.day == currentDT.day + 1) {
      return "Tomorrow";
    } else {
      String weekday = _setWeekDay(dateTime.weekday);

      String month = _setMonth(dateTime.month);
      String day = "${dateTime.day}";

      bool equalsYears = dateTime.year == currentDT.year;
      String year = !equalsYears ? ", ${dateTime.year}" : '';

      return '$weekday, $month $day$year';
    }
  }

  String _setWeekDay(int weekday) {
    Map weekdays = {
      1: "Mon",
      2: "Tue",
      3: "Wed",
      4: "Thu",
      5: "Fri",
      6: "Sat",
      7: "Sun",
    };
    return weekdays[weekday];
  }

  String _setMonth(int month) {
    Map months = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "June",
      7: "July",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    return months[month];
  }
}
