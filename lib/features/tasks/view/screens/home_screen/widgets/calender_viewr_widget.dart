import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/providers/date_provider.dart';
import '../../../../controller/providers/theme_provider.dart';

class CalenderViewrWidget extends StatelessWidget {
  const CalenderViewrWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final theme = Provider.of<ThemeProvider>(context);
     return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<DateProvider>(builder: (context, dateProvider, child) {
          return (DatePicker(
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.indigo,
            selectedTextColor: Colors.white,
            monthTextStyle: TextStyle(
              color: theme.isDark ? Colors.white : Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            dayTextStyle: TextStyle(
              color: theme.isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            dateTextStyle: TextStyle(
              color: theme.isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            onDateChange: (date) {
              dateProvider.selectedDatePicker(date);

              // print(dateProvider.selectedDateFromPicker);
            },
          ));
        }),
      ),
    );
  }
}