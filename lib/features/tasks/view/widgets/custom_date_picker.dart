import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/date_provider.dart';
import '../../controller/providers/theme_provider.dart';

class CustomDateChoosePicker extends StatelessWidget {
  final String? label;
  final Icon icon;
  final TextEditingController controller;
  const CustomDateChoosePicker(
      {Key? key,
      required this.label,
      required this.controller,
      required this.icon})
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
            controller.text = DateFormat.yMd().format(dateProvider.chooseDate);
            value = controller.text;
          },
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 15,
          ),
          cursorColor: themeProvider.isDark ? Colors.white : Colors.grey[800],
          decoration: InputDecoration(
            hintText: DateFormat.yMd().format(dateProvider.chooseDate),
            suffixIcon: InkWell(
              onTap: () {
                _openDateUserPicker(context);
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

  _openDateUserPicker(BuildContext context) async {
    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2115),
    );
    dateProvider.getDateTime(_pickerDate);
  }
}
