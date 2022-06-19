import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  ColorPickerWidget({Key? key,required this.passColor,this.selectedColor = 0}) : super(key: key);
   int selectedColor;
  final TextEditingController passColor;
  @override
  _ColorIconsState createState() => _ColorIconsState();
}

class _ColorIconsState extends State<ColorPickerWidget> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(3, (int index) {
        return InkWell(
          onTap: () {
            setState(() {
              widget.selectedColor = index;
              widget.passColor.text = index.toString();
              print(widget.selectedColor);
            });

          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              child: widget.selectedColor == index ? const Icon(
                Icons.done,
                color: Colors.white,
              ):Container(),
              radius: 14,
              backgroundColor: index == 0
                  ? Colors.indigo
                  : index == 1
                  ? Colors.pink
                  : Colors.deepPurple,
            ),
          ),
        );
      }),
    );
  }
}
