import 'package:flutter/material.dart';

class ColorIcons extends StatefulWidget {
  ColorIcons({Key? key,required this.passColor}) : super(key: key);
  int selectedColor = 0;
  TextEditingController passColor = TextEditingController();
  @override
  _ColorIconsState createState() => _ColorIconsState();
}

class _ColorIconsState extends State<ColorIcons> {

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
