import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String labelOne, labelTwo;
  const CustomRichText({
    Key key,
    this.labelOne,
    this.labelTwo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: labelOne,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        TextSpan(
          text: labelTwo,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }
}
