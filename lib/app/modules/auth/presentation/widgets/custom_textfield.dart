import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool filled;
  final String labelText;
  final Color fillColor;
  final double height;
  final TextEditingController controller;
  final bool isName;
  final bool isPassword;
  final bool isPasswordMatcher;
  final bool isSurname;
  final bool isEmail;
  final String password;
  final FormFieldSetter<String> onSaved;

  CustomTextField({
    Key key,
    this.filled = false,
    this.labelText = '',
    this.fillColor,
    this.height,
    this.controller,
    this.isName = false,
    this.isPassword = false,
    this.isPasswordMatcher = false,
    this.isSurname = false,
    this.isEmail = false,
    this.password,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: '',
      onSaved: onSaved,
      validator: (value) {
        var password;
        if (value.isEmpty) {
          return "*field shouldn't be empty";
        } else if (isName || isSurname) {
          if (value.length <= 3) return '*should be at least 3 characters';
        } else if (isPassword) {
          password = value;
          if (value.length <= 3) return '*password to week';
        } else if (isPasswordMatcher) {
          print(password);
          if (password != value) return "*password doesn't match";
        }
        return null;
      },
      builder: (FormFieldState<String> state) => Container(
        child: Column(
          children: [
            Container(
              height: height ?? null,
              child: TextField(
                controller: controller,
                onChanged: (value) => state.didChange(value),
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)),
                    filled: filled,
                    fillColor: filled ? fillColor : null,
                    labelText: labelText,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle:
                        TextStyle(color: Colors.black26, fontSize: 15.0)),
              ),
            ),
            // getting error message
            (state.hasError)
                ? Container(
                    alignment: Alignment.centerLeft,
                    child: Text(state.errorText,
                        style: TextStyle(color: Colors.amber, fontSize: 12)))
                : Container(width: 0.0, height: 0.0),
          ],
        ),
      ),
    );
  }
}
