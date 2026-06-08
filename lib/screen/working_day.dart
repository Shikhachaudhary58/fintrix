bool isSecondOrFourthSaturday(DateTime date) {
  if (date.weekday != DateTime.saturday) return false;

  int weekOfMonth = ((date.day - 1) ~/ 7) + 1;

  return weekOfMonth == 2 || weekOfMonth == 4;
}

List<DateTime> getWorkingDays(DateTime startDate, int days) {
  List<DateTime> result = [];
  DateTime current = startDate;

  while (result.length < days) {
    current = current.add(const Duration(days: 1));

    bool isSunday = current.weekday == DateTime.sunday;
    bool isBlockedSaturday = isSecondOrFourthSaturday(current);

    if (!isSunday && !isBlockedSaturday) {
      result.add(current);
    }
  }

  return result;
}

// List<DateTime> getWorkingDays(DateTime startDate, int days) {
//   List<DateTime> result = [];
//   DateTime current = startDate;

//   while (result.length < days) {
//     current = current.add(const Duration(days: 1));

//     bool isWeekend =
//         current.weekday == DateTime.saturday ||
//         current.weekday == DateTime.sunday;

//     if (!isWeekend) {
//       result.add(current);
//     }
//   }

//   return result;
// }

String formatDate(DateTime date) {
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  return "${date.day} ${months[date.month - 1]} ${date.year}";
}

String getWorkingDaysRange() {
  final days = getWorkingDays(DateTime.now(), 3);

  return "${formatDate(days.first)} to ${formatDate(days.last)}";
}
