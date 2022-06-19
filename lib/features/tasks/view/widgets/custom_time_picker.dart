import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/date_provider.dart';
import '../../controller/providers/theme_provider.dart';

class CustomEndTimeChoosePicker extends StatelessWidget {
  String? label, hint;
  Icon icon;
  TextEditingController controller = TextEditingController();
  CustomEndTimeChoosePicker(
      {Key? key,
      required this.label,
      required this.controller,
      required this.icon,
      required this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    OutlineInputBorder outLineDesign() {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: themeProvider.isDark ? Colors.white : Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Consumer(builder: (context, provider, child) {
        return TextFormField(
          controller: controller,
          readOnly: true,
          onSaved: (value) {
            controller.text = hint!;
            value = controller.text;
          },
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 15,
          ),
          cursorColor: themeProvider.isDark ? Colors.white : Colors.grey[800],
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: InkWell(
              onTap: () {
                _openEndTimeUserPicker(context);
              },
              child: icon,
            ),
            labelText: label,
            labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeProvider.isDark ? Colors.white : Colors.grey[800]),
            enabledBorder: outLineDesign(),
            focusedBorder: outLineDesign(),
            border: outLineDesign(),
          ),
        );
      }),
    );
  }

  _openEndTimeUserPicker(BuildContext context) async {
    final dateProvider = Provider.of<DateProvider>(context, listen: false);

    TimeOfDay? _endTimeDate = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: dateProvider.chooseEndHour,
    );
    dateProvider.getEndTimeTask(_endTimeDate);
  }
}

class CustomStartTimeChoosePicker extends StatelessWidget {
  final String? label, hint;
  final Icon icon;
  final TextEditingController controller;
  const CustomStartTimeChoosePicker(
      {Key? key,
      required this.label,
      required this.controller,
      required this.icon,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    OutlineInputBorder outLineDesign() {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: themeProvider.isDark ? Colors.white : Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Consumer(builder: (context, provider, child) {
        return TextFormField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 15,
          ),
          onSaved: (value) {
            controller.text = dateProvider.chooseHour.format(context);
            value = controller.text;
          },
          cursorColor: themeProvider.isDark ? Colors.white : Colors.grey[800],
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: InkWell(
              onTap: () {
                _openTimeUserPicker(context);
              },
              child: icon,
            ),
            labelText: label,
            labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeProvider.isDark ? Colors.white : Colors.grey[800]),
            enabledBorder: outLineDesign(),
            focusedBorder: outLineDesign(),
            border: outLineDesign(),
          ),
        );
      }),
    );
  }

  _openTimeUserPicker(BuildContext context) async {
    final dateProvider = Provider.of<DateProvider>(context, listen: false);

    TimeOfDay? _timeDate = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: dateProvider.chooseHour,
    );
    dateProvider.getStartTimeTask(_timeDate);
  }
}
