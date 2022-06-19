
import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime chooseDate = DateTime.now();
  TimeOfDay chooseHour = TimeOfDay.now();
  TimeOfDay chooseEndHour = TimeOfDay.now();
  DateTime? selectedDateFromPicker = DateTime.now();

  selectedDatePicker(DateTime date) {
    selectedDateFromPicker = date;
    notifyListeners();
  }

  getStartTimeTask(TimeOfDay? time) {
    if (time != null) {
      chooseHour = time;
      print(chooseHour);
      notifyListeners();
    } else {
      print("no thing to show");
    }
  }

  getEndTimeTask(TimeOfDay? time) {
    if (time != null) {
      chooseEndHour = time;
      print(chooseHour);
      notifyListeners();
    } else {
      print("no thing to show");
    }
  }

  getDateTime(DateTime? date) {
    if (date != null) {
      chooseDate = date;
      notifyListeners();
      print(chooseDate);
    } else {
      print("no thing to show");
    }
  }
}
