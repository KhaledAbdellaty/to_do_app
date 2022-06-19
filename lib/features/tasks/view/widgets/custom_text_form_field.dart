import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/theme_provider.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final TextEditingController controller;



  const CustomTextFormField(
      {Key? key,
  
      required this.label,
      required this.controller,
    })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: TextFormField(
        controller: controller,
        autocorrect: true,
        autofocus: false,
        style: const TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 15,
        ),
        cursorColor: theme.isDark ? Colors.white : Colors.grey[800],
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: theme.isDark ? Colors.white : Colors.grey[800]),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.isDark ? Colors.white : Colors.black,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.isDark ? Colors.white : Colors.black,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.isDark ? Colors.white : Colors.black,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
