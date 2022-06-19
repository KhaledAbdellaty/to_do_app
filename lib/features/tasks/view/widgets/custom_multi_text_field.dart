import 'package:flutter/material.dart';

class CustomMultiTextField extends StatelessWidget {
  final String value;
  final TextEditingController controller;
  final int maxLines;
  final String label;

  const CustomMultiTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.maxLines,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      minLines: 1,
      maxLines: maxLines,
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => controller.text = newValue!,
      style: const TextStyle(
          color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          label: Text(label),
          labelStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
