import 'package:flutter/material.dart';

import '../../../modules/auth/presentation/widgets/custom_text.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final bool isGreenColor;
  final VoidCallback onTap;
  final double width;
  final double btnWidth;
  final double btnHeight;
  final double textSize;
  final Color textColor;
  final double iconSize;
  final Color color, borderColor, iconColor;
  const RoundedButton(
      {Key key,
      this.icon,
      this.text = '',
      this.isSelected = false,
      this.isGreenColor = false,
      this.onTap,
      this.width,
      this.btnWidth,
      this.btnHeight,
      this.textSize,
      this.textColor,
      this.iconSize,
      this.color,
      this.borderColor,
      this.iconColor})
      : super(key: key);

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
                    color: isGreenColor
                        ? Colors.green
                        : borderColor ?? Colors.white,
                    width: 0.7),
                borderRadius: BorderRadius.circular(80),
                color: isSelected
                    ? Colors.white
                    : isGreenColor ? Colors.green : color ?? Colors.black45),
            child: Icon(icon,
                color: isSelected
                    ? Colors.black
                    : isGreenColor ? Colors.white : iconColor ?? Colors.black,
                size: iconSize ?? 50),
          ),
        ),
        SizedBox(height: 5.0),
        CustomText(
            text: text, width: 90, fontSize: textSize, textColor: textColor),
      ],
    );
  }
}
