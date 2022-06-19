import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/providers/theme_provider.dart';

class CustomDropDown extends StatefulWidget {
  final String label;
  String selectedItem;
  final TextEditingController controller;
  CustomDropDown({
    Key? key,
    this.selectedItem = 'Daily',
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> listItem = ['Daily', 'Weakly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    OutlineInputBorder outLineDesign() {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: themeProvider.isDark ? Colors.white : Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      );
    }

    return DropdownButtonFormField(
      value: widget.selectedItem,
      decoration: InputDecoration(
        label: Text(widget.label),
        labelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: themeProvider.isDark ? Colors.white : Colors.grey[800]),
        enabledBorder: outLineDesign(),
        focusedBorder: outLineDesign(),
        border: outLineDesign(),
      ),
      items: listItem.map(_buildDropItem).toList(),
      onSaved: (String? value) {
        widget.controller.text = widget.selectedItem;
        widget.selectedItem = value!;
        setState(() {
          widget.controller.text = widget.selectedItem;
        });
      },
      onChanged: (String? newValue) {
        widget.controller.text = widget.selectedItem;
        widget.selectedItem = newValue!;
        setState(() {
          widget.controller.text = widget.selectedItem;
        });
      },
    );
  }

  DropdownMenuItem<String> _buildDropItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }
}
