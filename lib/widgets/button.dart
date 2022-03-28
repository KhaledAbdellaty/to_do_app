import 'package:flutter/material.dart';

import 'package:to_do_app/screens/addTask_screen.dart';

class MyButton extends StatelessWidget {
  String? label;
  Icon? icon;

  MyButton({Key? key,required this.label,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskPage()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon!,
            Text(label!),
          ],
        ));
  }
}
