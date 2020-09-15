import 'package:flutter/material.dart';

import 'custom_text.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final bool hasCustomColor;
  final VoidCallback onTap;
  final double width;
  final double btnWidth;
  final double btnHeight;
  final double textSize;
  final Color textColor;
  const RoundedButton({
    Key key,
    this.icon,
    this.text = '',
    this.isSelected = false,
    this.hasCustomColor = false,
    this.onTap,
    this.width,
    this.btnWidth,
    this.btnHeight,
    this.textSize,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: btnWidth ?? 90,
            height: btnHeight ?? 90,
            decoration: BoxDecoration(
                border: Border.all(
                    color: hasCustomColor ? Colors.green : Colors.white,
                    width: 0.7),
                borderRadius: BorderRadius.circular(80),
                color: isSelected
                    ? Colors.white
                    : hasCustomColor ? Colors.green : Colors.black45),
            child: Icon(icon,
                color: !isSelected ? Colors.white : Colors.black, size: 50),
          ),
        ),
        SizedBox(height: 5.0),
        CustomText(
            text: text, width: 90, fontSize: textSize, textColor: textColor),
      ],
    );
  }
}
