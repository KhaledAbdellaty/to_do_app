import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime chooseDate = DateTime.now();
  //String hourFormat = DateFormat("hh:mm a").format(DateTime.now()).toString();
  TimeOfDay chooseHour = TimeOfDay.now();
  TimeOfDay chooseEndHour = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  getDateUserPicker(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2115),
    );

    if (_pickerDate != null) {
      chooseDate = _pickerDate;
      print(chooseDate);
      notifyListeners();
    } else {
      print("no thing to show");
    }
  }

  getTimeUserPicker(BuildContext context) async {
    TimeOfDay? _timeDate = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: chooseHour,
    );
    if (_timeDate != null) {
      chooseHour = _timeDate;
      print(chooseHour);
      notifyListeners();
    } else {
      print("no thing to show");
    }
  }

  getEndTimeUserPicker(BuildContext context) async {
    TimeOfDay? _endTimeDate = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: chooseEndHour,
    );
    if (_endTimeDate != null) {
      chooseEndHour = _endTimeDate;
      print(chooseEndHour);
      notifyListeners();
    } else {
      print("no thing to show");
    }
  }

}
