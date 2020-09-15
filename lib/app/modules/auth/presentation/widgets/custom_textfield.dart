import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool filled;
  final String labelText;
  final Color fillColor;
  final double height;
  final TextEditingController controller;
  const CustomTextField({
    Key key,
    this.filled = false,
    this.labelText = '',
    this.fillColor,
    this.height,
    this.controller,
  }) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12.0)),
            filled: filled,
            fillColor: filled ? fillColor : null,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black26, fontSize: 15.0)),
      ),
    );
  }
}
