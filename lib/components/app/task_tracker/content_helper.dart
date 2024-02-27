import 'package:edupot/components/common/select_time_modal.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/add_notes_modal.dart';
import 'package:edupot/widgets/common/input_field.dart';
import 'package:flutter/material.dart';

List<String> headlines = [
  "My Exam",
  "My Task",
  "My Project",
];

List<Color> colorsPalete = [
  EduPotColorTheme.examsOrange,
  EduPotColorTheme.tasksPurple,
  EduPotColorTheme.projectBlue,
];

void buildDatePicker(
  BuildContext context,
  DateTime time,
  void Function(DateTime) date,
) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: EduPotColorTheme.primaryLightDark,
              onPrimary: Colors.white,
              surface: EduPotColorTheme.primaryDark,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ))),
        child: child!,
      );
    },
  );
  if (pickedDate != null && pickedDate != time) {
    date(DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      time.hour,
      time.minute,
    ));
  }
}

void timeModal(
  BuildContext context,
  DateTime time,
  void Function(DateTime) date,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: EduPotColorTheme.primaryDark,
    builder: (BuildContext context) {
      return SelectTimeModal(
        selectedTime: (DateTime selectedTime) {
          date(DateTime(
            time.year,
            time.month,
            time.day,
            selectedTime.hour,
            selectedTime.minute,
          ));
        },
      );
    },
  );
}

void showNotesModal(
  BuildContext context, {
  required void Function() addNotes,
  required void Function() importNotes,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: EduPotColorTheme.primaryDark,
    builder: (BuildContext context) =>
        AddNotesModal(addNotes: addNotes, importNotes: importNotes),
  );
}

Widget buildInputField(
        String headline, String placeholder, Function(String)? onChanged,
        {String? initialValue}) =>
    InputField(
      headline: headline,
      placeholder: placeholder,
      validatorText: "",
      textChanged: onChanged ?? (String input) {},
      initialValue: initialValue,
    );
