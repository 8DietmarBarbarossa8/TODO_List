class DataTimeFormat {
  static String setDataFormat(DateTime? dateTime) {
    DateTime currentDT = DateTime.now();

    if (dateTime == null) {
      return "";
    }

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

  static String _setWeekDay(int weekday) {
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

  static String _setMonth(int month) {
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