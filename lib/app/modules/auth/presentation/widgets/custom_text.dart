import 'package:flutter/material.dart';

import '../../../../core/domain/configs/core_config.dart';

class CustomText extends StatelessWidget {
  final double width;
  final String text;
  final Color textColor;
  final double fontSize;
  final bool bold;
  const CustomText({
    Key key,
    this.width,
    this.text = '',
    this.textColor,
    this.fontSize,
    this.bold = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? getWidth(context),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: bold ? FontWeight.bold : null),
      ),
    );
  }
}
