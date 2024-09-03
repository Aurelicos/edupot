List<List<List<int>>> generateDate(DateTime date) {
  DateTime lastmonth = DateTime(date.year, date.month - 1, date.day);
  DateTime nextmonth = DateTime(date.year, date.month + 1, date.day);

  return [
    getDates(lastmonth.year, lastmonth.month),
    getDates(date.year, date.month),
    getDates(nextmonth.year, nextmonth.month),
  ];
}

List<List<int>> getDates(int year, int month) {
  List<List<int>> listofDays = [];

  int weeks = 0;
  for (int i = 0; i < 31; i++) {
    DateTime day = DateTime(year, month, i + 1);
    if (day.weekday == 1 && day.month == month || i == 0 && day.weekday != 1) {
      listofDays.add([]);
      weeks++;
    }
    if (day.month == month) {
      listofDays[weeks - 1].add(day.day);
    }
  }

  return listofDays;
}
