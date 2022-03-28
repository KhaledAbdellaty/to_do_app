import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/date_provider.dart';
import '../providers/theme_provider.dart';

class MyEndTimePicker extends StatelessWidget {
  String? label,hint;
  Icon icon;
  TextEditingController controller = TextEditingController();
  MyEndTimePicker({Key? key, required this.label, required this.controller,required this.icon,required this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final dateProvider = Provider.of<DateProvider>(context);
    final theme = Provider.of<ThemeProvider>(context);

    OutlineInputBorder outLineDesign(){
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: theme.isDark ? Colors.white : Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Consumer(
          builder: (context,provider,child) {
            return TextFormField(
              controller: controller,
              readOnly: true,
              onSaved: (value){
                controller.text = hint!;
                value = controller.text;
              },
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 15,
              ),
              cursorColor: theme.isDark ? Colors.white : Colors.grey[800],
              decoration: InputDecoration(
                hintText: hint,
                suffixIcon: InkWell(
                  onTap: () {
                    dateProvider.getEndTimeUserPicker(context);
                  },
                  child: icon ,
                ),
                labelText: label,
                labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.isDark ? Colors.white : Colors.grey[800]),
                enabledBorder: outLineDesign(),
                focusedBorder: outLineDesign(),
                border: outLineDesign(),
              ),
            );
          }),
    );
  }

}
