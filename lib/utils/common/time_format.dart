String formatTime(DateTime date) {
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  int hour = date.hour;
  String amPm = hour >= 12 ? 'pm' : 'am';

  hour = hour % 12;
  hour = hour != 0 ? hour : 12;

  String formattedHour = hour.toString();

  String formattedDate = "$day.$month ($formattedHour$amPm)";

  return formattedDate;
}
