import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class MyDropDown extends StatefulWidget {
  String label;
  String selectedItem = 'Daily' ;
  TextEditingController controller = TextEditingController();
  MyDropDown({Key? key,required this.label,required this.controller}) : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  List<String> listItem = ['Daily','Weakly','Monthly'];


  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    OutlineInputBorder outLineDesign(){
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: theme.isDark ? Colors.white : Colors.black,
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
            color: theme.isDark ? Colors.white : Colors.grey[800]),
        enabledBorder: outLineDesign(),
        focusedBorder: outLineDesign(),
        border: outLineDesign(),

      ),
        items: listItem.map(buildDropItem).toList(),
        onChanged: (String? newValue){
          widget.controller.text = widget.selectedItem;
          setState(() {
            widget.selectedItem = newValue!;
            widget.controller.text = widget.selectedItem;
          });
        },
    );
  }
  DropdownMenuItem<String> buildDropItem(String value){
  return DropdownMenuItem<String>(
  value: value,
  child: Text(value),
  );
  }
}
